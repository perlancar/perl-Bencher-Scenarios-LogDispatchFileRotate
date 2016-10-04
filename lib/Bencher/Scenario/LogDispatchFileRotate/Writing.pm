package Bencher::Scenario::LogDispatchFileRotate::Writing;

# DATE
# VERSION

use strict;
use warnings;

use File::Temp;

our $scenario = {
    summary => 'Benchmark writing using Log::Dispatch::FileRotate',
    precision => 6,
    participants => [
        {
            name => 'ldfr',
            module => 'Log::Dispatch::FileRotate',
            function => 'log',
            code_template => <<'_',
state $tempdir = File::Temp::tempdir(CLEANUP => 0);
warn "tempdir=$tempdir";
state $file = Log::Dispatch::FileRotate->new(name => 'file1', min_level => 'info', filename => "$tempdir/file1", mode => 'append', size => 10, max => 6);
$file->log(level => 'info', message => <str>) for 1..1000;
_
        },
    ],
    datasets => [
        {name => "1k x 100b", args => {str => ("a" x 99) . "\n"}},
    ],
};

1;
# ABSTRACT:

=head1 SEE ALSO
