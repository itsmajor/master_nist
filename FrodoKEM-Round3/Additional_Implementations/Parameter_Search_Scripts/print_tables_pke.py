"""Generation of LaTeX tables for the paper and CDFs for the C code.

Copyright (c) 2016 Joppe Bos, Leo Ducas, Ilya Mironov, Valeria Nikolaenko,
                   Ananth Raghunathan, Douglas Stebila

Released under the MIT License; see LICENSE.txt for details.
"""
from __future__ import division
from __future__ import print_function

from collections import namedtuple
from math import log, floor

from numpy import log2

from approx_distr import approximate_dgauss
from discrete_distr import dgauss, bits_needed_to_sample, nonnegative_half, \
    pdf_product, distribution_to_c
from failure_prob_pke import exact_failure_prob_pke
from pqsec import optimize_attack, svp_classical, svp_quantum, svp_plausible, \
    primal_cost, dual_cost
from renyi import renyi

ParameterSet = namedtuple('ParameterSet', ['name', 'sigma', 'n', 'm_bar',
                                             'n_bar', 'q', 'B', 'key_len',
                                             'rand_bits', 'sec_base', 'distr',
                                             'a'])


def distribution_to_tex(p):
    """Format distribution as a TeX string.

    Args:
      p: A ParameterSet tuple.

    Returns:
      LaTeX string.
    """

    dg = dgauss(p.sigma)

    b = bits_needed_to_sample(p.distr)
    ret = '$\chi_{}$ & {:g} &'.format(p.name, p.sigma)

    for i in sorted(p.distr):
        if i >= 0:
            q = int(round(p.distr[i] * 2 ** b))
            if i == 0:
                q *= 2
            ret += r'\!\!{}\!\!&'.format(q)

    for i in range(max(p.distr), 12):
        ret += '&'

    divergence = renyi(p.distr, nonnegative_half(dg), p.a)
    ret += r' {:g} & ${:.3f}\times 10^{{-4}}$'.format(p.a,
                                                      divergence * 10 ** 4)
    return ret + r' \\'


def security_to_tex(p):
    """Format security estimates as two rows of a LaTeX table.

    Args:
      p: A ParameterSet tuple.
      print_sec: If true, output will include security estimates.

    Returns:
      LaTeX string.
    """
    lwe_samples = p.n + max(p.m_bar, p.n_bar)
    ret = ''

    ret += r'\multirow{2}{*}{' + p.name + '} '

    for cost in [primal_cost, dual_cost]:
        _, _, cost_pc = optimize_attack(
            2 ** p.q, p.n, lwe_samples, p.sigma, cost, svp_classical)
        _, _, cost_pq = optimize_attack(
            2 ** p.q, p.n, lwe_samples, p.sigma, cost, svp_quantum)
        _, _, cost_pp = optimize_attack(
            2 ** p.q, p.n, lwe_samples, p.sigma, cost, svp_plausible)

        if cost == primal_cost:
            ret += '& Primal & '
        else:
            ret += '& Dual & '

        ret += r'{:.1f} & {:.1f} & {:.1f} \\'.format(
            cost_pc, cost_pq, cost_pp) + '\n'

    return ret


def parameters_to_tex(p):
    """Format parameters as a TeX string.

    Args:
      p: A ParameterSet tuple.

    Returns:
      LaTeX string.
    """

    s = p.name
    s += r' & \!\! {} \!\!'.format(p.n)
    s += r' & \!\! $2^{{{}}}$ \!\!'.format(p.q)
    s += r' & {:g}'.format(p.sigma)
    s += r' &$[{}\dots {}]$'.format(-max(p.distr), max(p.distr))
    s += r' &\!\!{}\!\!'.format(p.B)

    s += r' & ${}\times {}$'.format(p.n_bar, p.m_bar)

    ct_len = (p.m_bar * p.n + p.m_bar * p.n_bar) * p.q // 8

    s += r' & {:,}'.format(ct_len)

    s += r' \\'

    return s


def print_sizes(p, prefix, kem):
    """Print sizes (in bytes) for a parameter setting.

    Args:
      p: A ParameterSet tuple.
      prefix: A prefix for the scheme's name (e.g., 'Frodo').
      kem: True if the scheme is a KEM, False is the scheme is PKE.

    Returns:
      LaTeX string.
    """
    len_a, len_s, len_d = 128, p.key_len, p.key_len

    if kem:
        name = p.name.replace(prefix, prefix + 'KEM')
        pk_bits = len_a + p.q * p.n * p.n_bar
        sk_bits = len_s + pk_bits + 16 * p.n * p.n_bar + len_d
        ct_bits = (p.m_bar * p.n + p.m_bar * p.n_bar) * p.q
        assert p.key_len % 8 == 0
        ss_str = '{:,} \\\\ \n & ({:,} + {:,})\\\\'.\
            format(p.key_len // 8, (sk_bits - pk_bits) // 8, pk_bits // 8)
    else:  # PKE
        name = p.name.replace(prefix, prefix + 'PKE')
        pk_bits = len_a + p.q * p.n * p.n_bar
        sk_bits = 16 * p.n * p.n_bar
        ct_bits = (p.m_bar * p.n + p.m_bar * p.n_bar) * p.q
        ss_str = ''

    assert pk_bits % 8 == 0 and sk_bits % 8 == 0 and ct_bits % 8 == 0

    return r'{} & {:,} & {:,} & {:,} & {}'.format(name, sk_bits // 8,
                                                  pk_bits // 8,
                                                  ct_bits // 8, ss_str)


def dlwe_to_ind_cca(p):
    """Compute IND-CCA security bound."""

    # Only compute the dual cost, since it is smaller than the primal cost.
    _, _, cost_pc = optimize_attack(2 ** p.q, p.n, max(p.n_bar, p.m_bar) + p.n,
                                    p.sigma, dual_cost, svp_classical)

    # Take into account the hybrid argument over mbar + nbar instances.
    cost_pc_hybrid = cost_pc - log2(p.n_bar + p.m_bar)

    # Use the Renyi divergence argument.
    samples = 2 * p.n * (p.n_bar + p.m_bar) + p.n_bar * p.m_bar
    sym_distr = pdf_product(p.distr, {+1: .5, -1: .5})
    failure_prob_log2 = log2(exact_failure_prob_pke(sym_distr, 2 ** p.q,
                                                    p.n, p.B, p.key_len))

    dg = dgauss(p.sigma)
    rd = renyi(sym_distr, dg, p.a)

    baseline = p.key_len + 18  # 2^18 ~ SHA-3 gate count.

    # Computation is done in log space (base 2).
    loss = (-baseline +
            log2(2 + 2 ** (p.key_len + failure_prob_log2)
                 + 3 * 2 ** (baseline - cost_pc_hybrid)) +
            samples * rd / log(2)) * (1 - 1 / p.a)

    return baseline - log2(1 + 2 ** (baseline + loss))


def security_bounds(p):
    """Print security bounds as a row of a LaTeX table."""
    def print_cost(attack_type):
        _, _, cost_pc = optimize_attack(
            2 ** p.q, p.n,
            max(p.n_bar, p.m_bar) + p.n, p.sigma, dual_cost, attack_type
        )  # Only compute the dual cost, since it is smaller than the primal cost.

        # Take into account the hybrid argument over mbar + nbar instances.
        cost_pc_hybrid = cost_pc - log2(p.n_bar + p.m_bar)
        return cost_pc_hybrid

    s = p.name
    # Mapping key length to security level: 128 -> 1, 192 -> 3, 256 -> 5.
    s += ' & ' + str(p.key_len // 32 - 3)

    sym_distr = pdf_product(p.distr, {+1: .5, -1: .5})
    failure_prob = exact_failure_prob_pke(sym_distr, 2 ** p.q, p.n, p.B,
                                          p.key_len)
    if failure_prob == 0:
        s += r' & $0$ '
    else:
        s += r' & $2^{{{:.1f}}}$'.format(log2(failure_prob))

    s += ' & {:g}'.format(floor(print_cost(svp_classical)))
    s += ' & {:g}'.format(floor(print_cost(svp_quantum)))
    s += ' & {:g}'.format(floor(print_cost(svp_plausible)))

    s += ' & {}'.format(int(floor(dlwe_to_ind_cca(p))))
    s += r' \\'

    return s


def main():
    # pyformat: disable
    parameters = [
        {'name': '\FrodoLOne', 'sigma': 2.8, 'n': 640, 'm_bar': 8, 'n_bar': 8,
         'q': 15, 'B': 2, 'key_len': 128, 'rand_bits': 16, 'sec_base': 105},
        {'name': '\FrodoLThree', 'sigma': 2.3, 'n': 976, 'm_bar': 8,
         'n_bar': 8, 'q': 16, 'B': 3, 'key_len': 192, 'rand_bits': 16,
         'sec_base': 151},
        {'name': '\FrodoLFive', 'sigma': 1.4, 'n': 1344, 'm_bar': 8,
         'n_bar': 8, 'q': 16, 'B': 4, 'key_len': 256, 'rand_bits': 16,
         'sec_base': 195},
    ]
    # pyformat: enable

    # Compute the error distribution as an approximation to the rounded
    # continuous Gaussian.
    for p in parameters:
        samples = 2 * (p['n_bar'] + p['m_bar']) * p['n'] + p['n_bar'] * p[
            'm_bar']
        _, p['distr'], p['a'] = approximate_dgauss(p['sigma'], samples,
                                                   p['sec_base'],
                                                   None, p['rand_bits'],
                                                   quiet=True)

    # Convert from dictionary representation to named tuples.
    params = [ParameterSet(**p) for p in parameters]

    print('### C Code ###')
    for p in params:
        print(distribution_to_c(p.distr))
    print()

    print('### TABLE 1 ###')
    for p in params:
        print(parameters_to_tex(p))
    print()

    print('### TABLE 2 ###')
    for p in params:
        print(security_bounds(p))
    print()

    print('### TABLE 3 ###')
    for p in params:
        print(distribution_to_tex(p))
    print()

    print('### TABLE 5 ###')
    for p in params:
        print(print_sizes(p, 'Frodo', kem=True))
    print()

    print('### TABLE 10 ###')
    for p in params:
        print(security_to_tex(p), end='')
        if p.key_len == 256:
            print(r'\bottomrule')
        else:
            print(r'\midrule')


if __name__ == '__main__':
    main()
