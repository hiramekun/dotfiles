# Display time
SPACESHIP_TIME_SHOW=true

# Display username always
SPACESHIP_USER_SHOW=always

# Do not truncate path in repos
SPACESHIP_DIR_TRUNC_REPO=false

# Add custom Ember section
# See: https://github.com/spaceship-prompt/spaceship-ember

SPACESHIP_PROMPT_SYMBOL="➜"
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_PROMPT_PREFIXES_SHOW=true
SPACESHIP_PROMPT_SUFFIXES_SHOW=true

# See: https://spaceship-prompt.sh/config/prompt/#prompt-order
SPACESHIP_PROMPT_ORDER=(
    time           # Time stamps section
    user           # Username section
    dir            # Current directory section
    host           # Hostname section
    git            # Git section (git_branch + git_status)
    package        # Package version
    node           # Node.js section
    python         # Python section
    swift          # Swift section
    golang         # Go section
    rust           # Rust section
    scala          # Scala section
    kotlin         # Kotlin section
    java           # Java section
    docker         # Docker section
    docker_compose # Docker section
    aws            # Amazon Web Services section
    gcloud         # Google Cloud Platform section
    kubectl        # Kubectl context section
    exec_time      # Execution time
    async          # Async jobs indicator
    line_sep       # Line break
    battery        # Battery level and status
    jobs           # Background jobs indicator
    exit_code      # Exit code section
    sudo           # Sudo indicator
    char           # Prompt character
)
