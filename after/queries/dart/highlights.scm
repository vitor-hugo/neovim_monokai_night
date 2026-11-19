; extends

; Dart's server can classify void as a keyword. Keep it the type color,
; above semantic-token and modifier priorities (125-127).
((void_type) @type.builtin
  (#set! priority 130))

; Named arguments are neutral in VSCode, rather than orange parameters.
((named_argument
  (label
    (identifier) @property))
  (#set! priority 130))
