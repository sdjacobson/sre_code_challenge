wall="%{%F{green}%}|%{%f%}"

function _prompt_char() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    echo "%{%F{blue}%}±%{%f%k%b%}"
  else
    echo ' '
  fi
}

function current_openstack() {
  if [[ $OS_TENANT_NAME ]]; then
    echo " ${wall} 🏘  %{%F{blue}%}$OS_TENANT_NAME - $OS_REGION_NAME%{%f%}"
  elif [[ $OS_PROJECT_NAME ]]; then
    echo " ${wall} 🏘  %{%F{blue}%}$OS_PROJECT_NAME - $OS_REGION_NAME%{%f%}"
  fi
}

function current_deploy_env() {
  if [[ $DEPLOY_ENV ]]; then
    echo " ${wall} ☛ $DEPLOY_ENV"
  fi
}

function current_docker() {
  if [[ $WSO_DOCKER_IMAGE ]]; then
    echo "🛥  ${WSO_DOCKER_IMAGE}"
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX=" %{%F{green}%}|%{%f%} %{%F{cyan}%}⚒  "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%}"
ZSH_THEME_GIT_PROMPT_DIRTY="🔺 "
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{%f%k%b%}
%{%K{${bkg}}%}$(current_docker)$(git_prompt_info)$(current_openstack)$(current_deploy_env)%E%{%f%k%b%}
%{%K{${bkg}}%B%F{green}%}%n%{%B%F{blue}%}@%{%B%F{cyan}%}%m%{%B%F{green}%} %{%b%F{yellow}%K{${bkg}}%}%~%{%B%F{green}%}%E%{%f%k%b%}
%{%K{${bkg}}%}$(_prompt_char)%{%K{${bkg}}%} %#%{%f%k%b%} '

RPROMPT='!%{%B%F{cyan}%}%!%{%f%k%b%}'
