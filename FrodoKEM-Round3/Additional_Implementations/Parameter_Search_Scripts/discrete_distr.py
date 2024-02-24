"""Support functions for manipulating discrete probability distributions.

A discrete probability distribution is represented as a dictionary mapping
values in its support to probability masses. Ex: {-1: .5, +1: .5}

A distribution may be defined over Z_q, which affects how the sums and products
are evaluated.

Copyright (c) 2016 Joppe Bos, Leo Ducas, Ilya Mironov, Valeria Nikolaenko,
                   Ananth Raghunathan, Douglas Stebila

Released under the MIT License; see LICENSE.txt for details.
"""

import numpy as np
import scipy.stats

NEGLIGIBLE = 1E-200  # < 2^{-650}


### Utility functions ###


def valid_distr(d):
    """Check whether the dictionary represents a distribution.

    Args:
      d: A distribution represented as a dictionary.

    Returns:
      True iff d is a valid distribution.
    """

    return abs(sum(d.values()) - 1.) < 1E-9 and all(x >= 0 for x in d.values())


def valid_symmetric_distr(d):
    """Check whether the dictionary represents a symmetric distribution.

    Args:
      d: A distribution represented as a dictionary.

    Returns:
      True iff d is a valid symmetric distribution.
    """

    return valid_distr(d) and all(abs(d[x] - d[-x]) < 1E-9 for x in d.keys())


def filter_negl(d):
    """Filter out negligible values from a distribution.

    Args:
      d: A distribution represented as a dictionary.

    Returns:
      Distribution represented as a dictionary.
    """

    return {v: p for (v, p) in d.items() if p >= NEGLIGIBLE}


def std_modulo(d, q):
    """Compute the standard deviation of a distribution defined over Z_q.

    Args:
      d: A distribution represented as a dictionary.
      q: A modulus.

    Returns:
      The distribution's standard deviation.
    """

    return sum([p * min(x, q - x) ** 2 for (x, p) in d.items()]) ** .5


### Operations on distributions ###


def convolution(a, b, q=None):
    """Compute a convolution of two probability distributions.

    Args:
      a, b: Two distributions represented as dictionaries.
      q: If q is defined, computation is done modulo q. If q is None,
         distributions are taken over integers.

    Returns:
      A distribution represented as a dictionary.

    Raises:
      ValueError: if the input distributions are not valid.
    """

    def mod_to_int(x):
        return x if x < q / 2 else x - q

    def dict_to_arr(x):
        """Convert a distribution into an (offset, array) pair.
        """
        min_x, max_x = min(x.keys()), max(x.keys())
        a = np.zeros(max_x - min_x + 1, dtype=np.float128)
        for i, p in x.items():
            a[i - min_x] = p
        return min_x, a

    if not (valid_distr(a) and valid_distr(b)):
        print(sum(a.values()), sum(b.values()))
        raise ValueError('One of the input distributions is not valid')

    if q is not None:
        a = {mod_to_int(v): p for v, p in a.items()}
        b = {mod_to_int(v): p for v, p in b.items()}

    min_a, ar_a = dict_to_arr(a)
    min_b, ar_b = dict_to_arr(b)

    ar_c = np.convolve(ar_a, ar_b)
    c = {}
    for i, p in enumerate(ar_c):
        if p >= NEGLIGIBLE:
            v = i + min_a + min_b
            if q is not None:
                v = (v + q) % q
                c[v] = c.get(v, 0) + p  # add, in case there's wraparound
            else:
                c[v] = p
    return c


def pdf_product(a, b, q=None):
    """Compute the product of two probability distributions.

    Args:
      a, b: Two distributions represented as dictionaries.
      q: If q is defined, computation is done modulo q. If q is None,
         distributions are taken over integers.

    Returns:
      A distribution represented as a dictionary.

    Raises:
      ValueError: The distributions are not valid.
    """
    if not (valid_distr(a) and valid_distr(b)):
        raise ValueError('One of the input distribution is not valid')

    c = {}
    for v, p_v in a.items():
        for u, p_u in b.items():
            w = v * u
            if q is not None:
                w %= q
            c[w] = c.get(w, 0) + p_v * p_u
    return filter_negl(c)


def nfoldconvolution(n, a, q):
    """Compute n-fold convolution of a distribution in log_2 n time.

    Args:
      n: A number of iterations.
      a: A distribution represented as a dictionary.
      q: If q is defined, computation is done modulo q. If q is None,
         distributions are taken over integers.

    Returns:
      A distribution represented as a dictionary.
    """
    r = {0: 1.0}
    n_bin = bin(n)[2:]  # binary representation of n
    for ch in n_bin:
        r = convolution(r, r, q)
        if ch == '1':
            r = convolution(r, a, q)
    return r


# Standard distributions


def dgauss(sigma):
    """Compute pdf of the rounded continuous Gaussian of std sigma.

    Args:
      sigma: Standard deviation.

    Returns:
      A distribution represented as a dictionary.
    """
    d = {}
    k = 0
    while True:
        # more numerically stable than cdf (which is ~1 for large k)
        p = (scipy.stats.norm.sf(k - .5, scale=sigma) -
             scipy.stats.norm.sf(k + .5, scale=sigma))
        if p < NEGLIGIBLE:
            break
        d[k] = p
        d[-k] = p
        k += 1
    return d


def uniform(l, u):
    if not l <= u:
        raise ValueError('Lower bound cannot be larger than upper bound!')
    p = 1. / (u - l + 1)
    d = {}
    for k in range(l, u + 1):
        d[k] = p
    return d


def sym_binomial(n):
    """Compute pdf of the symmetric binomial distribution.

    Args:
      n: A number of coins. n is even.

    Returns:
      A distribution on [-n/2 ..n/2] represented as a dictionary.

    Raises:
      ValueError: n is not even.
    """
    if n % 2 != 0:
        raise ValueError('n should be even')
    d = {}
    for k in range(n + 1):
        d[k - n / 2] = scipy.stats.binom.pmf(k, n, .5)
    return d


def nonnegative_half(d):
    """Output the nonnegative half of a symmetric distribution.

    Assuming that d is symmetric distribution, outputs a distribution d2 so
    that d = sign * d2, where sign is random {-1, +1}.

    Args:
      d: A distribution represented as a dictionary.

    Returns:
      A distribution represented as a dictionary.

    Raises:
      ValueError: The input distribution is not symmetric.
    """
    if not valid_symmetric_distr(d):
        raise ValueError(
            'The input distribution is not a valid symmetric distribution')

    d1 = {v: x for (v, x) in d.items() if v >= 0}
    if 0 in d1:
        d1[0] /= 2
    s = sum(d1.values())  # must be 1 - d1[0]
    return {v: x / s for (v, x) in d1.items()}  # normalize


def cutoff_tails(d, cutoff_prob):
    """Cut off tails from a distribution, re-scaling it if necessary."""
    s = sum(p for p in d.values() if p >= cutoff_prob)
    return {v: p / s for (v, p) in d.items() if p >= cutoff_prob}


def distr_to_str(d):
    """Print a distribution to string.

    Args:
      d: A distribution represented as a dictionary.

    Returns:
      Distribution as a comma-separated string in a canonical order.
    """
    r = ['({}: {})'.format(key, d[key]) for key in sorted(d)]
    return ', '.join(r)


def bits_needed_to_sample(d):
    """Count the number of bits required to sample from the distribution.

    Args:
      d: A distribution represented as a dictionary.

    Returns:
      Number of bits required to sample from a distribution. None if undefined.
    """
    b = 1
    while b <= 64:
        if all(np.fmod(x, 2 ** -b) == 0. for x in d.values()):
            return b
        b += 1

    return None


def bits_to_c_type(bits):
    if bits <= 8:
        return 'uint8_t'
    if bits <= 16:
        return 'uint16_t'
    if bits <= 32:
        return 'uint32_t'
    if bits <= 64:
        return 'uint64_t'
    raise ValueError('Cannot represent input using a C integer type.')


def distribution_to_c(distr):
    """Format CDF as a string for use in C code.

    Args:
      distr: A discrete distribution as a dictionary.

    Returns:
      Valid C code as a string.
    """

    n = max(distr.keys()) + 1  # range is [0..n)
    ret = 'size_t CDF_TABLE_LEN = {};\n'.format(n)

    b = bits_needed_to_sample(distr)

    assert b < 16

    cdf = [0] * n
    s = 0  # cumulative sum

    for i in range(n):
        if i in distr:
            s += distr[i] * (1 << b)
        cdf[i] = s

    ret += '{} CDF_TABLE[{}] = {{'.format(bits_to_c_type(b + 1), n)
    ret += ', '.join(['{}'.format(int(x) - 1) for x in cdf])
    ret += '};'
    return ret
