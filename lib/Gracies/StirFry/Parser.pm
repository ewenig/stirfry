#!/usr/bin/perl

use warnings;
use strict;
use 5.10.1;

=pod

=head1 NAME

Gracies::StirFry::Parser - A stirfry-focused parser for the Gracie's Menu website

=head1 SYNOPSIS

use Gracies::StirFry::Parser;
my $parser = Gracies::StirFry::Parser->new({
						file => '/path/to/file.cfm'
						});
my @stirfry = $parser->get_stir_fry;

=head1 DESCRIPTION

Parses the Gracie's Weekly Menu HTML file and returns an array representing when there is stir fry.

The Gracie's Weekly Menu is currently located at http://finweb.rit.edu/diningservices/forms/webmenus/gracies-weekly.cfm

=cut


package Gracies::StirFry::Parser;
use XML::DOM::Lite qw(Parser);
use Moose;

has 'file' => (
    is  => 'ro',
	isa => 'Str'
);

=pod

=head1 METHODS

=head2 get_stir_fry

Using the file name, parses for stir fry.

=cut

sub get_stir_fry {
    my $self = shift;
	my @weekdays = ('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');
	my @stirfry;
	my ($node,$text,$id,$j);
	my $dom = Parser->parseFile($self->file, whitespace => 'strip');
	for (my $i=0;$i<7;$i++) {
		for (my $k=0;$k<3;$k++) {
			$j=0;
			$id = 'meal_' . $weekdays[$i] . '_' . ($k+1);
			$node = $dom->getElementById($id);
			if ($node eq "") { $stirfry[$i][$k] = "No data"; $j=1;}
			if ($j==0) {
				$text = $node->xml;
				if ($text =~ m/Stir( |-)Fry/i) {
					$stirfry[$i][$k] = "Yes";
				} else {
					$stirfry[$i][$k] = "No";
				}
			}
		}
	}

	return @stirfry;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Eli Wenig, <lt>eli@csh.rit.edu<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Eli Wenig

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
