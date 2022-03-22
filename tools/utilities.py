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
    parser.add_argument('softs',
        nargs='*',
        # type=str,
        # default='ubuntu',
        # required=False,
        # metavar='OS name',
        help='The name of packages, eg: zsh vim tmux')
    return parser.parse_args()


def load_settings():
    # load settings json file
    settings_file = os.path.join(BASE_DIR, 'tools', 'config.json')
    try:
        open_json_file = open(settings_file)
        settings_data = json.load(open_json_file)
        return settings_data
    except Error:
        print("Error!!!")
    finally:
        open_json_file.close()


def get_install_command(data, os, install_method):
    install_commands = data['commands']['install']
    if install_method == 'system' and os in install_commands:
        return install_commands[os]
    elif install_method == 'brew':
        return install_commands['default']
    else:
        return None


def install_command(softs, os="ubuntu"):
    install_bash_text = "set -eux; \\\n"
    install_bash_text += "\\\n"
    settings_json = load_settings()
    packages = settings_json.get('packages')
    for soft_name in softs:
        if soft_name in packages:
            soft_meta = packages[soft_name]
            if os in soft_meta:
                install_name = soft_meta[os]['name']
                install_method = soft_meta[os]['method']
                install_cmd = get_install_command(settings_json, os, install_method)
                install_soft_cmd = ' '.join((install_cmd, install_name, ';'))
                install_bash_text += install_soft_cmd
                install_bash_text += ' \\\n'
            elif "default" in soft_meta:
                install_name = soft_meta['default']['name']
                install_method = soft_meta['default']['method']
                install_cmd = get_install_command(settings_json, os, install_method)
                install_soft_cmd = ' '.join((install_cmd, install_name, ';'))
                install_bash_text += install_soft_cmd
                install_bash_text += ' \\\n'
            else:
                print("no install meta info")
                return
    install_bash_text += ":;"
    return install_bash_text


if __name__ == "__main__":
    args = get_args()
    if args.action == 'install':
        install_text = install_command(args.softs, args.os)
        print(install_text)
    # print(args.os)
    # print(args.action)
    # print(args.softs)

# vim:set et sts=4 ts=4 sw=4 tw=78:
