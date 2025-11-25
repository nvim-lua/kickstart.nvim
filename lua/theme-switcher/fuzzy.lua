local M = {}

-- Simple fuzzy match algorithm
-- Returns score (higher is better) or nil if no match
function M.fuzzy_match(str, pattern)
  if pattern == '' then
    return 1000 -- Empty pattern matches everything with high score
  end

  str = str:lower()
  pattern = pattern:lower()

  local str_idx = 1
  local pattern_idx = 1
  local score = 0
  local consecutive = 0
  local last_match_idx = 0

  while pattern_idx <= #pattern do
    local pattern_char = pattern:sub(pattern_idx, pattern_idx)
    local found = false

    -- Search for pattern character in remaining string
    while str_idx <= #str do
      local str_char = str:sub(str_idx, str_idx)

      if str_char == pattern_char then
        found = true

        -- Score bonuses
        score = score + 1

        -- Bonus for consecutive matches
        if str_idx == last_match_idx + 1 then
          consecutive = consecutive + 1
          score = score + consecutive * 5
        else
          consecutive = 0
        end

        -- Bonus for matching at start
        if str_idx == 1 then
          score = score + 10
        end

        -- Bonus for matching after separator
        if str_idx > 1 then
          local prev_char = str:sub(str_idx - 1, str_idx - 1)
          if prev_char == '-' or prev_char == '_' or prev_char == ' ' then
            score = score + 8
          end
        end

        last_match_idx = str_idx
        str_idx = str_idx + 1
        break
      end

      str_idx = str_idx + 1
    end

    if not found then
      return nil -- Pattern doesn't match
    end

    pattern_idx = pattern_idx + 1
  end

  return score
end

-- Filter and sort themes by fuzzy match
function M.filter_themes(themes, query)
  if query == '' then
    return themes
  end

  local matches = {}

  for _, theme in ipairs(themes) do
    local score = M.fuzzy_match(theme, query)
    if score then
      table.insert(matches, { theme = theme, score = score })
    end
  end

  -- Sort by score (descending)
  table.sort(matches, function(a, b)
    return a.score > b.score
  end)

  -- Extract just the theme names
  local filtered = {}
  for _, match in ipairs(matches) do
    table.insert(filtered, match.theme)
  end

  return filtered
end

return M
