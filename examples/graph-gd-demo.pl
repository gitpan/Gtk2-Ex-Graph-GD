use strict;
use warnings;

use Gtk2::Ex::Graph::GD;
use GD::Graph::Data;
use Gtk2 -init;
use Glib qw /TRUE FALSE/;

my $graph = Gtk2::Ex::Graph::GD->new(500, 300, 'bars');

# All the properties set here go straight into the GD::Graph::* object created inside.
# Therefore, any property acceptable to the GD::Graph::* object can be passed through here
$graph->set (
	x_label         => 'TRE Label',
	y_label         => 'Y label',
	title           => 'A Simple Bar Chart',
	x_labels_vertical => 1,
	bar_spacing     => 1,
	shadowclr       => 'dred',
	transparent     => 0,
);

my @legend_keys = ('First', 'Second');
$graph->set_legend(@legend_keys);

my $data = GD::Graph::Data->new([
    ["1st","2nd","3rd","4th","5th","6th","7th", "8th", "9th"],
    [    1,    2,    5,    6,    3,  1.5,    1,     3,     4],
    [    1.4,  4,   15,    6,    13,  1.5,    11,     3,     4],
]) or die GD::Graph::Data->error;

# This actually returns an eventbox instead of an image. 
# But you don't <really> care either way, do you ?
my $image = $graph->get_image($data);

my $window = Gtk2::Window->new;
$window->signal_connect(destroy => sub { Gtk2->main_quit; });
$window->set_default_size(700, 500);
$window->add($image);
$window->show_all;
Gtk2->main;
