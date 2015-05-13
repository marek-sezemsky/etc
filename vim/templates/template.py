#!/usr/bin/env python
"""
Hi there!
"""
import argparse

def main():
    parser = argparse.ArgumentParser(
            description='Process some integers')
    parser.add_argument('integers', metavar='N', type=int, nargs='+',
            help='an integer for the accumulator')
    parser.add_argument('--sum', dest='accumulate', action='store_const',
            const=sum, default=max,
            help='sum the integers (default: find the max)')

    print(parser.parse_args())


if __name__ == '__main__':
    main()
