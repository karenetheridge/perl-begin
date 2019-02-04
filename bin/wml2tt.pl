#!/usr/bin/env perl

use strict;
use warnings;

s#<(cpan_dist|cpan_self_dist|cpan_b_self_dist|cpan_self_mod|pdoc_f|wiki_link) ([^>]*?)/>#
    my ($tag, $args) = ($1, $2);
    "[% $tag( " . ($args =~ s{([a-z]+)="([^"]+)"}{"$1" => "$2",}gr) . ") %]"
    #eg;

s#<pdoc_f f="(\w+)">#[%- WRAPPER pdoc_f f = "$1" -%]#g;
s#<cpan_dist d="([^"]*)">#[%- WRAPPER cpan_dist d = "$1" -%]#g;
s#<pdoc d="(\w+)">#[%- WRAPPER pdoc d = "$1" -%]#g;
s#</(?:cpan_dist|pdoc|pdoc_f)>#[%- END -%]#g;
s/\$\(ROOT\)\//[% base_path %]/g;

s{\A#include "template5.wml"\n+<latemp_subject ("[^"]*") />\n+}{[%- SET title = $1 -%]
[%- PROCESS "blocks.tt2" -%]
[%- WRAPPER wrap_html -%]\n\n};

$_ .= "\n[% END %]\n";
