#use Grammar::Tracer;
grammar Debian::IndexParse::Grammar {
    # https://www.debian.org/doc/debian-policy/ch-controlfields.html
    token TOP {
        # A control file consists of one or more paragraphs of fields.
        # Some control files allow only one paragraph; others allow several.
        # The paragraphs are separated by empty lines.
        # The ordering of the paragraphs in control files is significant
        ^
          <emptyline>*
          <paragraph>+ %% <emptyline>+
        $
        { make map
            { %( map { .<name>.Str => .<value>.Str }, .<field> ) },
              $/<paragraph>
        }
    }
    token emptyline {
        \n
    }
    token paragraph {
        <field>+
    }
    token field {
        <name> \s* ":" \s* <value> "\n"
    }
    token name {
        # The field name is composed of US-ASCII characters excluding
        # control characters, space, and colon (i.e., characters in
        # the ranges 33-57 and 59-126, inclusive). Field names must
        # not begin with the comment character, #, nor with the hyphen
        # character, -.
        <[a..z A..Z 0..9
          ! " $ % & ' ( ) * + , . / ; < = > ? @
          \[ \\ \] ^ _ ` { | } ~]>
        <[a..z A..Z 0..9
          ! " # $ % & ' ( ) * + , \- . / ; < = > ? @
          \[ \\ \] ^ _ ` { | } ~]>*
    }
    token value {
        <-[\n]>+ <continuationline>*
    }
    token continuationline {
        \n <[\  \t]> <-[\n]>*
    }
}
