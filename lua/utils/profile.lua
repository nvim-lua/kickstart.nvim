local PROFILES = {
  ['HOME'] = {
    'python',
    'nix',
    'go',
    'rust',
    'markdown',
    'bash',
    'docker',
    'lua',
    'yaml',
  },
  ['DEFAULT'] = {
    'python',
    'markdown',
    'bash',
    'docker',
    'lua',
    'yaml',
  },
}

local Profile = {}
Profile.Languages = function(profile)
  if profile == nil then
    profile = os.getenv 'NVIM_PROFILE' or 'DEFAULT'
  end
  return PROFILES[profile]
end

Profile.LanguageServers = function(profile)
  local languages = Profile.Languages(profile)
  local language_config = require 'utils.languages'

  local result = {} -- <nvim_ls_name> -> {<configuration>}
  for _, lang in ipairs(languages) do
    for lsp, config in pairs(language_config[lang]) do
      result[lsp] = config
    end
  end
  return result
end

return Profile
