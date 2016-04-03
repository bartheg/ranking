# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

languages = [
  # most used on the internet
  { iso_639_1: "en", english_name: "English" },
  { iso_639_1: "ru", english_name: "Russian" },
  { iso_639_1: "de", english_name: "German" },
  { iso_639_1: "ja", english_name: "Japanese" },
  { iso_639_1: "es", english_name: "Spanish" },
  { iso_639_1: "fr", english_name: "French" },
  { iso_639_1: "zh", english_name: "Chinese" },
  { iso_639_1: "pt", english_name: "Portuguese" },
  { iso_639_1: "it", english_name: "Italian" },
  { iso_639_1: "pl", english_name: "Polish" },
  { iso_639_1: "tr", english_name: "Turkish" },
  { iso_639_1: "nl", english_name: "Dutch" },
  { iso_639_1: "fa", english_name: "Persian" },
  { iso_639_1: "ar", english_name: "Arabic" },
  { iso_639_1: "ko", english_name: "Korean" },
  { iso_639_1: "cs", english_name: "Czech" },
  { iso_639_1: "sv", english_name: "Swedish" },
  { iso_639_1: "vi", english_name: "Vietnamese" },
  { iso_639_1: "id", english_name: "Indonesian" },
  { iso_639_1: "ms", english_name: "Malay" },
  { iso_639_1: "el", english_name: "Greek" },
  { iso_639_1: "ro", english_name: "Romanian" },
  { iso_639_1: "hu", english_name: "Hungarian" },
  { iso_639_1: "da", english_name: "Danish" },
  { iso_639_1: "th", english_name: "Thai" },
  { iso_639_1: "fi", english_name: "Finnish" },
  { iso_639_1: "sk", english_name: "Slovak" },
  { iso_639_1: "bg", english_name: "Bulgarian" },
  { iso_639_1: "no", english_name: "Norwegian" },
  { iso_639_1: "he", english_name: "Hebrew" },
  { iso_639_1: "lt", english_name: "Lithuanian" },
  { iso_639_1: "hr", english_name: "Croatian" },
  { iso_639_1: "uk", english_name: "Ukrainian" },
  { iso_639_1: "sr", english_name: "Serbian" },
  { iso_639_1: "ca", english_name: "Catalan" },
  { iso_639_1: "sl", english_name: "Slovene" },
  { iso_639_1: "lv", english_name: "Latvian" },
  { iso_639_1: "et", english_name: "Estonian" },
  { iso_639_1: "hi", english_name: "Hindi" },
  { iso_639_1: "bn", english_name: "Bengali" },
  { iso_639_1: "tl", english_name: "Tagalog" },
  { iso_639_1: "uz", english_name: "Uzbek" },
  { iso_639_1: "af", english_name: "Afrikaans" },
  { iso_639_1: "ur", english_name: "Urdu" },
  { iso_639_1: "be", english_name: "Belarusian" },
  { iso_639_1: "ga", english_name: "Irish" },
  { iso_639_1: "bs", english_name: "Bosnian" },
  { iso_639_1: "kk", english_name: "Kazakh" },
  { iso_639_1: "az", english_name: "Azerbaijani" },
  { iso_639_1: "si", english_name: "Sinhalese" },
  { iso_639_1: "ka", english_name: "Georgian" },
  { iso_639_1: "ky", english_name: "Kyrgyz" },
  { iso_639_1: "mk", english_name: "Macedonian" },
  { iso_639_1: "tg", english_name: "Tajik" },
  { iso_639_1: "mn", english_name: "Mongolian" },
  { iso_639_1: "tk", english_name: "Turkmen" }
]

users = [
  # temp mails
  { email: 'chinczyk-123qwe@yopmail.com', password: "123qweasd"  },
  { email: 'polak-123qwe@yopmail.com', password: "123qweasd"  },
  { email: 'arab-123qwe@yopmail.com', password: "123qweasd"  },
  { email: 'amerykanin-123qwe@yopmail.com', password: "123qweasd"  },
  { email: 'anglik-123qwe@yopmail.com', password: "123qweasd"  },
  { email: 'fin-123qwe@yopmail.com', password: "123qweasd"  },
  { email: 'hiszpan-123qwe@yopmail.com', password: "123qweasd"  }
]

Language.create(languages)
User.create(users)
