int ntt_512_40961[512] =
{
	1, 14541, 31679, 37894, 8555, 40659, 15869, 17816, 31337, 21153, 34988, 24888, 39251, 39178, 20313, 1562,
	26395, 5125, 30312, 26432, 32193, 16105, 36030, 21040, 14642, 35005, 1554, 27203, 3572, 1904, 23106, 22224,
	16872, 20323, 28960, 28280, 34357, 24781, 20672, 19734, 34237, 223, 28565, 19125, 26385, 23559, 249, 16141,
	8448, 329, 25979, 18297, 17436, 29247, 36920, 18854, 4033, 28662, 4048, 1011, 13153, 10864, 18595, 6334,
	10486, 20084, 33245, 34784, 3140, 28186, 18752, 36416, 10640, 6543, 37452, 13037, 9858, 22639, 4918, 35693,
	4493, 40879, 35233, 23826, 16197, 35788, 27277, 9494, 14184, 10909, 33727, 39215, 17638, 17337, 5201, 13735,
	9233, 27856, 30667, 27401, 15507, 37943, 980, 36713, 26978, 3601, 25758, 40655, 22516, 3883, 30471, 3674,
	28046, 9170, 25144, 1018, 24953, 9035, 20709, 25258, 18286, 18875, 11732, 33408, 6671, 7363, 12810, 20543,
	24551, 20976, 24622, 29362, 26758, 40500, 19748, 19058, 25185, 23745, 38218, 10051, 2815, 12876, 4288, 9166,
	20625, 32644, 10464, 27870, 27848, 38283, 19735, 34830, 2006, 5014, 17563, 32709, 39632, 8603, 6517, 20904,
	26840, 4032, 36883, 13330, 29795, 4598, 11482, 2726, 32867, 27060, 6034, 1932, 20881, 27689, 10010, 20977,
	21305, 7962, 6698, 31321, 28786, 37728, 37912, 25254, 11446, 11743, 11062, 39656, 23740, 24993, 15500, 18078,
	1901, 34727, 9109, 27056, 1538, 40313, 19673, 34430, 14343, 29112, 32485, 2133, 26170, 10280, 29751, 20170,
	40631, 34868, 31946, 29046, 3159, 17738, 6238, 19104, 21923, 23841, 4962, 20121, 31807, 14936, 14314, 17033,
	1209, 7800, 1376, 19448, 20823, 3531, 15873, 35019, 38469, 14313, 28740, 24218, 21621, 15286, 22778, 4252,
	2936, 11014, 28074, 6708, 8387, 14470, 18727, 579, 7026, 8332, 35541, 37705, 17643, 8120, 40713, 39361,
	1024, 21141, 39145, 13389, 35627, 18440, 29300, 15939, 16625, 33264, 27798, 7570, 10283, 17453, 33285, 2009,
	35181, 4992, 32011, 32108, 32988, 25198, 29820, 40435, 1682, 4245, 34778, 2392, 12199, 24529, 26047, 24021,
	32347, 2564, 40237, 40254, 37030, 20885, 32252, 13843, 37033, 23547, 4406, 4642, 24941, 39348, 9210, 21101,
	7981, 9208, 18807, 16951, 36429, 6437, 40038, 13865, 33692, 21812, 8091, 11239, 33464, 24305, 35376, 14178,
	5882, 3594, 4289, 23707, 20402, 25920, 32300, 15474, 40695, 23389, 11352, 37563, 18186, 39371, 38790, 12420,
	13200, 38915, 32912, 26029, 37484, 27778, 37207, 14099, 24222, 29424, 6325, 14380, 38472, 16975, 894, 15017,
	33562, 15688, 26882, 339, 27261, 22604, 20456, 32875, 17758, 934, 38269, 14344, 36302, 2975, 30983, 34725,
	5443, 10011, 23948, 18407, 33169, 35615, 29179, 17801, 5687, 35369, 11995, 7357, 31578, 2888, 9920, 23039,
	31131, 15860, 21913, 1314, 38244, 19468, 28179, 17956, 24971, 25007, 17477, 11013, 15290, 36543, 8085, 5915,
	25085, 3280, 24315, 30024, 7496, 2115, 14867, 29850, 6094, 14211, 2633, 28879, 31778, 2857, 37726, 24054,
	40290, 32668, 2150, 9907, 35096, 38798, 1761, 6076, 26827, 19804, 34666, 12240, 502, 8524, 9990, 16884,
	25068, 1849, 18265, 241, 25905, 7249, 31821, 13705, 5858, 23259, 22252, 15393, 19887, 33168, 20093, 38461,
	21457, 6300, 29469, 15708, 18394, 32785, 33301, 29860, 23194, 32041, 4308, 13259, 9586, 40704, 31001, 9736,
	30729, 27801, 25826, 5418, 39858, 17989, 38757, 24099, 2524, 428, 1924, 521, 6373, 16011, 34459, 33367,
	9186, 40766, 16350, 7706, 23032, 11176, 33396, 18581, 28735, 33435, 19762, 17827, 20964, 5762, 17863, 12182,
	16311, 14061, 34115, 28505, 27439, 30359, 6700, 19442, 26449, 12080, 20616, 24658, 2631, 40758, 32775, 40


};

int intt_512_40961[512] =
{
	1, 26420, 3067, 9282, 23145, 25092, 302, 32406, 39399, 20648, 1783, 1710, 16073, 5973, 19808, 9624,
	18737, 17855, 39057, 37389, 13758, 39407, 5956, 26319, 19921, 4931, 24856, 8768, 14529, 10649, 35836, 14566,
	34627, 22366, 30097, 27808, 39950, 36913, 12299, 36928, 22107, 4041, 11714, 23525, 22664, 14982, 40632, 32513,
	24820, 40712, 17402, 14576, 21836, 12396, 40738, 6724, 21227, 20289, 16180, 6604, 12681, 12001, 20638, 24089,
	20418, 28151, 33598, 34290, 7553, 29229, 22086, 22675, 15703, 20252, 31926, 16008, 39943, 15817, 31791, 12915,
	37287, 10490, 37078, 18445, 306, 15203, 37360, 13983, 4248, 39981, 3018, 25454, 13560, 10294, 13105, 31728,
	27226, 35760, 23624, 23323, 1746, 7234, 30052, 26777, 31467, 13684, 5173, 24764, 17135, 5728, 82, 36468,
	5268, 36043, 18322, 31103, 27924, 3509, 34418, 30321, 4545, 22209, 12775, 37821, 6177, 7716, 20877, 30475,
	1600, 248, 32841, 23318, 3256, 5420, 32629, 33935, 40382, 22234, 26491, 32574, 34253, 12887, 29947, 38025,
	36709, 18183, 25675, 19340, 16743, 12221, 26648, 2492, 5942, 25088, 37430, 20138, 21513, 39585, 33161, 39752,
	23928, 26647, 26025, 9154, 20840, 35999, 17120, 19038, 21857, 34723, 23223, 37802, 11915, 9015, 6093, 330,
	20791, 11210, 30681, 14791, 38828, 8476, 11849, 26618, 6531, 21288, 648, 39423, 13905, 31852, 6234, 39060,
	22883, 25461, 15968, 17221, 1305, 29899, 29218, 29515, 15707, 3049, 3233, 12175, 9640, 34263, 32999, 19656,
	19984, 30951, 13272, 20080, 39029, 34927, 13901, 8094, 38235, 29479, 36363, 11166, 27631, 4078, 36929, 14121,
	20057, 34444, 32358, 1329, 8252, 23398, 35947, 38955, 6131, 21226, 2678, 13113, 13091, 30497, 8317, 20336,
	31795, 36673, 28085, 38146, 30910, 2743, 17216, 15776, 21903, 21213, 461, 14203, 11599, 16339, 19985, 16410,
	40921, 8186, 203, 38330, 16303, 20345, 28881, 14512, 21519, 34261, 10602, 13522, 12456, 6846, 26900, 24650,
	28779, 23098, 35199, 19997, 23134, 21199, 7526, 12226, 22380, 7565, 29785, 17929, 33255, 24611, 195, 31775,
	7594, 6502, 24950, 34588, 40440, 39037, 40533, 38437, 16862, 2204, 22972, 1103, 35543, 15135, 13160, 10232,
	31225, 9960, 257, 31375, 27702, 36653, 8920, 17767, 11101, 7660, 8176, 22567, 25253, 11492, 34661, 19504,
	2500, 20868, 7793, 21074, 25568, 18709, 17702, 35103, 27256, 9140, 33712, 15056, 40720, 22696, 39112, 15893,
	24077, 30971, 32437, 40459, 28721, 6295, 21157, 14134, 34885, 39200, 2163, 5865, 31054, 38811, 8293, 671,
	16907, 3235, 38104, 9183, 12082, 38328, 26750, 34867, 11111, 26094, 38846, 33465, 10937, 16646, 37681, 15876,
	35046, 32876, 4418, 25671, 29948, 23484, 15954, 15990, 23005, 12782, 21493, 2717, 39647, 19048, 25101, 9830,
	17922, 31041, 38073, 9383, 33604, 28966, 5592, 35274, 23160, 11782, 5346, 7792, 22554, 17013, 30950, 35518,
	6236, 9978, 37986, 4659, 26617, 2692, 40027, 23203, 8086, 20505, 18357, 13700, 40622, 14079, 25273, 7399,
	25944, 40067, 23986, 2489, 26581, 34636, 11537, 16739, 26862, 3754, 13183, 3477, 14932, 8049, 2046, 27761,
	28541, 2171, 1590, 22775, 3398, 29609, 17572, 266, 25487, 8661, 15041, 20559, 17254, 36672, 37367, 35079,
	26783, 5585, 16656, 7497, 29722, 32870, 19149, 7269, 27096, 923, 34524, 4532, 24010, 22154, 31753, 32980,
	19860, 31751, 1613, 16020, 36319, 36555, 17414, 3928, 27118, 8709, 20076, 3931, 707, 724, 38397, 8614,
	16940, 14914, 16432, 28762, 38569, 6183, 36716, 39279, 526, 11141, 15763, 7973, 8853, 8950, 35969, 5780,
	38952, 7676, 23508, 30678, 33391, 13163, 7697, 24336, 25022, 11661, 22521, 5334, 27572, 1816, 19820, 39937,


};