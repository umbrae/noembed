package Noembed::Source::AsciiArtFarts;

use Web::Scraper;

use parent 'Noembed::Source';

sub prepare_source {
  my $self = shift;
  $self->{scraper} = scraper {
    process 'td[bgcolor="#000000"] font', color => '@color';
    process 'td[bgcolor="#000000"] pre', art => 'RAW';
    process 'h1', title => 'TEXT';
  };
}

sub patterns { 'http://www\.asciiartfarts\.com/[0-9]+\.html' }
sub provider_name { "ASCII Art Farts" }

sub serialize {
  my ($self, $body) = @_;
  my $data = $self->{scraper}->scrape($body);
  $data->{art} = html($data->{art});
  return +{
    html => $self->render($data),
    title => $data->{title},
  };
}

1;
