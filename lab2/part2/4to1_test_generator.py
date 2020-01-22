# SW[4:0] data inputs
# SW[9] (s0) and SW[8] (s1) select signal
#
# LEDR[0] output display


def bin_rep(num, lst=None):
    if not lst:
        lst = ['1', '0']
    if num == 1:
        return lst
    else:
        new_lst = []
        for item in lst:
            new_lst.append(item + '1')
            new_lst.append(item + '0')
        return bin_rep(num - 1, new_lst)


def separator(st):
    lst = []
    for digit in st:
        lst.append(digit)
    return lst


def get_output(inp: str, switch: str):
    # switch -> {s1}{s0}
    mapping = {'00': 0, '01': 1, '10': 2, '11': 3}
    return inp[mapping[switch]]


inputs = bin_rep(4)
switches = bin_rep(2)

for i in inputs:
    for s in switches:
        u, v, w, x = separator(i)
        s1, s0 = separator(s)
        output = get_output(i, s)
        print(f'# Expected output: {output}')
        print(f'force {{SW[9]}} {s0}')
        print(f'force {{SW[8]}} {s1}')
        print(f'force {{SW[0]}} {u}')
        print(f'force {{SW[1]}} {v}')
        print(f'force {{SW[2]}} {w}')
        print(f'force {{SW[3]}} {x}')
        print('run 10ns')
        print()
