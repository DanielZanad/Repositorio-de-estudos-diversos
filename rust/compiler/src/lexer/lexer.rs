use std::io;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum LexerError {
    #[error("IO Error")]
    FileIO(#[from] io::Error),

    #[error("Was expecting {expected:?}, found {found:?}")]
    MissingExpectedSymbol { expected: TokenType, found: Token },
}

pub type Token = TokenType;

#[derive(Debug)]
pub enum TokenType {
    /** End of Token Stream */
    EOF,

    /** Punctuation like, ( [*/
    Punctuation {
        raw: char,
        kind: PunctuationKind,
    },

    /** Operators are 'actions' that you take on an entity i.e '*', '->' */
    Operator(String),

    /** A sequence of characters */
    Identifier(String),

    /** A single characters 'a' => unicode codepoint (32 bits) */
    Char(char),

    Numeric(String),

    /** For Errors */
    Unknown(char),
}

#[derive(Debug)]
pub enum PunctuationKind {
    /** '(' and '[' */
    Open(usize),

    /** ')' and ']' */
    Close(usize),

    /** ','  and ';' */
    Separator,
}

pub struct Lexer<'a> {
    /** Human Readable position in file */
    pub cur_line: usize,
    pub cur_col: usize,

    /** 'raw' format / offset within the file (in terms of 'codepoints') */
    pub codepoint_offset: usize,

    chars: std::iter::Peekable<std::str::Chars<'a>>,
}

impl<'a> Lexer<'a> {
    pub fn new(chars: &'a str) -> Lexer<'a> {
        Lexer {
            cur_col: 1,
            cur_line: 1,

            codepoint_offset: 0,
            chars: chars.chars().peekable(),
        }
    }
}
