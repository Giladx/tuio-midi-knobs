$:.unshift File.join( File.dirname( __FILE__ ), '.')
$:.unshift File.join( File.dirname( __FILE__ ), 'midiator', 'lib' )
$:.unshift File.join( File.dirname( __FILE__ ), 'tuio-ruby-0.2.0')
 
require 'midiator'
require 'tuio_midi_knobs/midi_interface'
require 'tuio_midi_knobs/tuio_object_controller'
require 'tuio_midi_knobs/knob'

require 'tuio_client'


class TuioMidiKnobs 
  def initialize
    @controller = TuioObjectController.new

    @tc = TuioClient.new 

    @tc.on_object_creation do |tuio|
      @controller.create_event( tuio )
    end

    @tc.on_object_update do |tuio|
      @controller.update_event( tuio )
    end
  end
  
  def start
    Thread.new do
      @tc.start
      sleep
    end
  end
end