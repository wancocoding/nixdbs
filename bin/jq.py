#!/usr/bin/env python3
import os
import argparse
import json


BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def get_args():
    parser = argparse.ArgumentParser(
        description='Process OS and command information or arguments!')
    parser.add_argument('--action',
        type=str,
        choices=['install', 'sync', 'update'],
        default='install',
        required=False,
        help='Want do you want to do in os, default: install')
    parser.add_argument('--os', '-O',
        # nargs=1,
        type=str,
        default='ubuntu',
        required=False,
        metavar='OS name',
        help='The name of distribution, eg: archlinux, default: ubuntu')
    parser.add_argument('--pkg', '-P',
        # nargs='1',
        type=str,
        # default='ubuntu',
        required=False,
        # metavar='OS name',
        help='The name of package, eg: zsh vim tmux')
    return parser.parse_args()


if __name__ == "__main__":
    args = get_args()
    try:
        pkg_meta_file = os.path.join(BASE_DIR,'bin', 'data', 'pkg_meta.json')
        open_file = open(pkg_meta_file)
        pkg_meta = json.load(open_file)
        pkg_name = pkg_meta[args.pkg][args.os]['name']
        # print(pkg_name)
        install_method = pkg_meta[args.pkg][args.os]['method']
        # print(install_method)
        print(' '.join((pkg_name, install_method)))
    except Exception as err:
        # print(err)
        print('none')
    finally:
        open_file.close()

# vim:set et sts=4 ts=4 sw=4 tw=78:
