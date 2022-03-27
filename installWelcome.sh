# We need the script to be sourced
if [ -z "$PS1" ] ; then
    echo -e "${red}This script must be sourced. Use \"source installWelcome.sh\" instead."
    exit 1
fi

# Define Colors
red='\e[0;31m'
green='\e[0;32m'
cyan='\e[0;36m'
lightgray='\e[0;37m'
purple='\e[1;35m'

# Detect the platform
case $(uname | tr '[:upper:]' '[:lower:]') in
  linux*)
    OS=linux
    ;;
  darwin*)
    OS=mac
    ;;
  *)
    ;;
esac

# Main function for the banner
function injectBanner(){
cat <<EOT >> ${1}

# Customised banner display by @sagarshah1729
if [ -f ~/.Banner.sh ]; then
    source ~/.Banner.sh
fi
EOT
}

function run_install()
{
    if [[ "${OS}" == linux ]]; then
       sudo apt-get install ${1}
    elif [[ "${OS}" == mac ]]; then
       sudo brew install ${1}
    fi
}

# First check the required libraries
package_check=false
packages=("curl" "figlet" "lolcat")
for pkg in ${packages[@]}; do
    is_pkg_installed=$(dpkg-query -W --showformat='${Status}\n' ${pkg} | grep "install ok installed")

    if [ "${is_pkg_installed}" != "install ok installed" ]; then
        echo -e "${red}\nFATAL ERROR: ${pkg} not found.\nPlease install ${pkg}."
        echo -e "${lightgray}"
    run_install "${pkg}"
    fi
    package_check=true
done

# Detect the shell being used for insertion inside the .rc
rcpath=""
if [[ "${package_check}" == "true" ]]; then
   echo -e "\nAll required Packages are installed!"
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
   # Assume Zsh
   echo -e "\nDetermined the default shell as ZSH."
   rcpath="${HOME}/.zshrc"
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
   # Assume Bash
   echo -e "\nDetermined the default shell as Bash."
   rcpath="${HOME}/.bashrc"
else
   # Assume something else
   read -p "Unable to determine the shell automatically, can I assume the shell as Bash? [Y/N]: " answer
   # Set the default value if no answer was given
   answer=${answer:Y}
   # If the answer matches y or Y, make bash as shell
   rcpath="${HOME}/.bashrc"
fi

if [ ! -z "${rcpath}" ]
then
   echo -e "\nInjecting the Welcome Banner inside ${rcpath}...."
   cp Banner.sh ~/.Banner.sh
   injectBanner "${rcpath}"
fi

fi
