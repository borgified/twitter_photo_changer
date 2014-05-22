#!/usr/bin/env perl

use warnings;
use strict;
use Net::Twitter 4.00005;
use Scalar::Util 'blessed';
use LWP::UserAgent;

my %config = do '/secret/twitter2.config';

my $consumer_key		= $config{consumer_key};
my $consumer_secret		= $config{consumer_secret};
my $token			= $config{token};
my $token_secret		= $config{token_secret};
#this is the full path of all the pictures to pick from
my $pool = $config{pool};

# As of 13-Aug-2010, Twitter requires OAuth for authenticated requests
my $nt = Net::Twitter->new(
    traits   => [qw/OAuth API::RESTv1_1/],
    consumer_key        => $consumer_key,
    consumer_secret     => $consumer_secret,
    access_token        => $token,
    access_token_secret => $token_secret,
		ssl									=> 1,
);

#pick a random png from ./pool/
my @files = (<$pool/*.png>);
my $randf = $files[rand @files];

eval {

	my $a=[$randf,$randf, 'Content_Type => image/png'];

#this updates your background
	#my $result = $nt->update_profile_banner($a);
	
#this updates your profile pic
	my $result = $nt->update_profile_image($a);

};

my $timestamp = localtime;

if ( my $err = $@ ) {
	die $@ unless blessed $err && $err->isa('Net::Twitter::Error');

	print "$timestamp using $randf\n",
			 "HTTP Response Code: ", $err->code, "\n",
			 "HTTP Message......: ", $err->message, "\n",
			 "Twitter error.....: ", $err->error, "\n";
} else {
	print "$timestamp picture updated to $randf\n";
}

