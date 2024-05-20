import os
import subprocess
import configparser
import sys

def get_profile_name(sso_account_id):
    config = configparser.ConfigParser()
    config.read(os.path.expanduser('~/.aws/config'))
    for section in config.sections():
        if config.has_option(section, 'sso_account_id') and config.get(section, 'sso_account_id') == sso_account_id:
            return section.split(' ')[1].replace('profile ', '')
    return None

def set_aws_profile(profile_name):
    os.environ['AWS_PROFILE'] = profile_name

def main():
    if len(sys.argv) < 2:
        print("Usage: python script.py <sso_account_id>")
        return

    sso_account_id = sys.argv[1]
    profile_name = get_profile_name(sso_account_id)

    if profile_name:
        set_aws_profile(profile_name)
        print(f"Exported AWS_PROFILE: {profile_name}")
    else:
        print(f"No profile associated with the provided sso_account_id: {sso_account_id}")
        return

    # Get AWS credentials
    subprocess.run(['aws', 'sso', 'login'])

    # Test credentials
    sts_caller_identity = subprocess.run(['aws', 'sts', 'get-caller-identity'], capture_output=True, text=True)
    if sts_caller_identity.returncode == 0:
        print("AWS credentials test successful:")
        print(sts_caller_identity.stdout)
        ##########
        print("")
        print("To maintain the AWS session export the profile to bash environment variables")
        print("")
        print("by Running below command:")
        print("")
        print(f"export AWS_PROFILE={profile_name}")
        print("")
        #########
    else:
        print("Failed to get AWS credentials.")

if __name__ == "__main__":
    main()
