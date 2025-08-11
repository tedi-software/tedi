#!/usr/bin/env bash

# run once or endlessly (for testing)
l_run_once=true
l_skip_file="/opt/tedi/services/test/ai_transform/groq/process.skip"

if [[ ${l_run_once} == true ]]; then
  if [[ ! -f ${l_skip_file} ]]; then
    touch ${l_skip_file}
  else
    echo "Process already executed, skipping. ${l_skip_file}" >&2
    exit 0
  fi
fi

# indicate the input file for TEDI
echo "/opt/tedi/services/test/ai_transform/groq/test.json"

l_rc=$?

exit ${l_rc}
