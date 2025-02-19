{-
Welcome to your new Dhall package-set!

Below are instructions for how to edit this file for most use
cases, so that you don't need to know Dhall to use it.

## Warning: Don't Move This Top-Level Comment!

Due to how `dhall format` currently works, this comment's
instructions cannot appear near corresponding sections below
because `dhall format` will delete the comment. However,
it will not delete a top-level comment like this one.

## Use Cases

Most will want to do one or both of these options:
1. Override/Patch a package's dependency
2. Add a package not already in the default package set

This file will continue to work whether you use one or both options.
Instructions for each option are explained below.

### Overriding/Patching a package

Purpose:
- Change a package's dependency to a newer/older release than the
    default package set's release
- Use your own modified version of some dependency that may
    include new API, changed API, removed API by
    using your custom git repo of the library rather than
    the package set's repo

Syntax:
where `entityName` is one of the following:
- dependencies
- repo
- version
-------------------------------
let upstream = --
in  upstream
  with packageName.entityName = "new value"
-------------------------------

Example:
-------------------------------
let upstream = --
in  upstream
  with halogen.version = "master"
  with halogen.repo = "https://example.com/path/to/git/repo.git"

  with halogen-vdom.version = "v4.0.0"
-------------------------------

### Additions

Purpose:
- Add packages that aren't already included in the default package set

Syntax:
where `<version>` is:
- a tag (i.e. "v4.0.0")
- a branch (i.e. "master")
- commit hash (i.e. "701f3e44aafb1a6459281714858fadf2c4c2a977")
-------------------------------
let upstream = --
in  upstream
  with new-package-name =
    { dependencies =
       [ "dependency1"
       , "dependency2"
       ]
    , repo =
       "https://example.com/path/to/git/repo.git"
    , version =
        "<version>"
    }
-------------------------------

Example:
-------------------------------
let upstream = --
in  upstream
  with benchotron =
      { dependencies =
          [ "arrays"
          , "exists"
          , "profunctor"
          , "strings"
          , "quickcheck"
          , "lcg"
          , "transformers"
          , "foldable-traversable"
          , "exceptions"
          , "node-fs"
          , "node-buffer"
          , "node-readline"
          , "datetime"
          , "now"
          ]
      , repo =
          "https://github.com/hdgarrood/purescript-benchotron.git"
      , version =
          "v7.0.0"
      }
-------------------------------
-}
let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.0-20220510/packages.dhall
        sha256:0b0d4db1f2f0acd3b37fa53220644ac6f64cf9b5d0226fd097c0593df563d5be

in  upstream
  with halogen-components =
    { dependencies =
      [ "console"
      , "css"
      , "effect"
      , "js-fileio"
      , "halogen"
      , "halogen-css"
      , "soundfonts"
      ]
    , repo =
        "https://github.com/newlandsvalley/purescript-halogen-components.git"
    , version = "ps015"
    }
  with drawing =
    { dependencies =  
      [ "canvas"
      , "colors"
      , "console"
      , "control"
      , "effect"
      , "foldable-traversable"
      , "lists"
      , "maybe"
      , "numbers"
      , "prelude"
      ]
    , repo = "https://github.com/newlandsvalley/purescript-drawing.git"
    , version = "ps015"
    }
  with optparse = 
    { dependencies = 
      [ "prelude"
      , "effect"
      , "exitcodes"
      , "strings"
      , "arrays"
      , "console"
      , "open-memoize"
      , "transformers"
      , "exists"
      , "node-process"
      , "free"
      , "quickcheck"
      , "spec"
      , "aff"
      , "bifunctors"
      , "control"
      , "either"
      , "enums"
      , "foldable-traversable"
      , "gen"
      , "integers"
      , "lazy"
      , "lists"
      , "maybe"
      , "newtype"
      , "node-buffer"
      , "node-streams"
      , "nonempty"
      , "numbers"
      , "partial"
      , "tailrec"
      , "tuples"
      ]
    , repo = "https://github.com/f-o-a-m/purescript-optparse.git"
    , version = "v5.0.0"
    }
