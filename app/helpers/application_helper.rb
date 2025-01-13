module ApplicationHelper

  MOOD_CATEGORIES = {
    high_energy_pleasant: ['Cheerful', 'Upbeat', 'Pleased', 'Excited', 'Happy'],
    low_energy_pleasant: ['Connected', 'Calm', 'Relaxed', 'Thoughtful', 'Good'],
    high_energy_unpleasant: ['Irate', 'Peeved', 'Tense', 'Angry', 'Anxious'],
    low_energy_unpleasant: ['Sad', 'Bored', 'Tired', 'Meh', 'Disappointed']
  }

  def mood_group(emotion)
    MOOD_CATEGORIES.each do |key, emotions|
      return key.to_s.dasherize if emotions.include?(emotion)
    end

    "neutral"
  end

end
