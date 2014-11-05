import json
import os

DEFAULT_PATH = os.path.expanduser("~/%s")


def read_manifest():
    print "Reading manifest"
    with open('manifest.json') as manifest_f:
        return json.load(manifest_f)


def get_local_repo_file_path(filename):
    return os.path.abspath(os.path.realpath(os.path.join('.', filename)))


def install_file(repo_file, dest_file_path):
    repo_file_path = get_local_repo_file_path(repo_file)

    if os.path.exists(dest_file_path):
        print "Not linking: File already exists at %s" % dest_file_path
        return

    try:
        os.remove(dest_file_path)
    except OSError:
        pass
    print "Linking %s -> %s" % (dest_file_path, repo_file_path)
    os.symlink(repo_file_path, dest_file_path)


def install_defaults(manifest):
    for repo_file in manifest['defaults']:
        dest_file_path = DEFAULT_PATH % repo_file

        install_file(repo_file, dest_file_path)


def install_custom(manifest):
    for repo_file, dest_file in manifest['custom'].iteritems():
        dest_file_path = os.path.expanduser(dest_file)

        install_file(repo_file, dest_file_path)


if __name__ == '__main__':
    manifest = read_manifest()
    install_defaults(manifest)
    install_custom(manifest)
