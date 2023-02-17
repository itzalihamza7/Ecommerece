module.exports = {
  env: {
    browser: true,
    es2021: true
  },
  extends: [
    'plugin:react/recommended',
    'standard'
  ],

  ignorePatterns: ['node_modules/*',
    '.next/*',
    '.out/*',
    '!.prettierrc.js'
  ],

  overrides: [
  ],
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module'
  },
  plugins: [
    'react'
  ],
  rules: {
    'no-tabs': 'off',
    'no-mixed-spaces-and-tabs': 'off',
    undefined: 'off',
    'react/prop-types': 'off'
  }
}
