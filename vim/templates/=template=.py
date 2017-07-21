#!/usr/bin/env python
"""
"""
import argparse
import logging

def parse_arguments():
    parser = argparse.ArgumentParser(description=__doc__)
    # ...

    parser.add_argument('-d','--debug',
                        help='Print lots of debugging statements',
                        action="store_const", dest="loglevel", const=logging.DEBUG,
                        default=logging.WARNING)
    parser.add_argument('-v','--verbose',
                        help='Be verbose',
                        action="store_const", dest="loglevel", const=logging.INFO)

    return parser.parse_args()


def main():
    args = parse_arguments()
    logging.basicConfig(level=args.loglevel,
                        format='{}: %(levelname)s: %(msg)s'.format(__file__))
    logging.debug("Debug message")
    logging.info("Info message")
    logging.warning("Warning message")


if __name__ == '__main__':
    main()
