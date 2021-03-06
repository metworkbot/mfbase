function batch_psql() {
    SQLFILE=$1
    INFO=${2:-}
    if test "${INFO}" = ""; then
        INFO="Playing ${SQLFILE}"
    fi
    echo -n "- ${INFO}..."
    echo_running
    psql -U "${MFBASE_POSTGRESQL_USERNAME}" -h "${MODULE_RUNTIME_HOME}/var" -p "${MFBASE_POSTGRESQL_PORT}" -f "${SQLFILE}" -v "ON_ERROR_STOP=1" "${MFBASE_POSTGRESQL_DBNAME}" >"/tmp/psql.$$" 2>&1
    if test $? -eq 0; then
        echo_ok
        rm -f "/tmp/psql.$$"
        return 0
    else
        echo_nok
        echo_bold "=> see /tmp/psql.$$ for more details => EXITING"
        return 1
    fi
}
