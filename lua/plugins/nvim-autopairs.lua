-- Autopairs Module
--
-- Focus: Auto-close brackets, quotes, and parentheses.
-- Principles:
-- 1. Single Responsibility: This file only handles bracket/quote pairing.
-- 2. Explicit Configuration: Pairing rules are clearly defined.

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,
  },
}

