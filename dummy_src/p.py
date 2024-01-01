import logging

def f(x: int) -> str:
    a = 100
    logging.debug(a)
    b = [200] * 10
    logging.info(a, b)
    c = {x: x*x for x in b}
    logging.warning(c)
    d = f'Values {x=} {a=} {b=} {c=}'
    logging.error(d)
    logging.exception('FATAL!!!!!!!###!@#')
    breakpoint()
    return d


if __name__ == '__main__':
    logging.debug('start')
    print(f(100500))
    logging.debug('end')
