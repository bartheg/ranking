# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

languages = [
  # most used on the internet
  { iso_639_1: "en", english_name: "English" },  # id:  1
  { iso_639_1: "ru", english_name: "Russian" },
  { iso_639_1: "de", english_name: "German" },
  { iso_639_1: "ja", english_name: "Japanese" },
  { iso_639_1: "es", english_name: "Spanish" },
  { iso_639_1: "fr", english_name: "French" },
  { iso_639_1: "zh", english_name: "Chinese" },
  { iso_639_1: "pt", english_name: "Portuguese" },
  { iso_639_1: "it", english_name: "Italian" },
  { iso_639_1: "pl", english_name: "Polish" },  # id:  10
  { iso_639_1: "tr", english_name: "Turkish" },
  { iso_639_1: "nl", english_name: "Dutch" },
  { iso_639_1: "fa", english_name: "Persian" },
  { iso_639_1: "ar", english_name: "Arabic" },
  { iso_639_1: "ko", english_name: "Korean" },
  { iso_639_1: "cs", english_name: "Czech" },
  { iso_639_1: "sv", english_name: "Swedish" },
  { iso_639_1: "vi", english_name: "Vietnamese" },
  { iso_639_1: "id", english_name: "Indonesian" },
  { iso_639_1: "ms", english_name: "Malay" },   # id:  20
  { iso_639_1: "el", english_name: "Greek" },
  { iso_639_1: "ro", english_name: "Romanian" },
  { iso_639_1: "hu", english_name: "Hungarian" },
  { iso_639_1: "da", english_name: "Danish" },
  { iso_639_1: "th", english_name: "Thai" },
  { iso_639_1: "fi", english_name: "Finnish" },
  { iso_639_1: "sk", english_name: "Slovak" },
  { iso_639_1: "bg", english_name: "Bulgarian" },
  { iso_639_1: "no", english_name: "Norwegian" },
  { iso_639_1: "he", english_name: "Hebrew" },     # id:  30
  { iso_639_1: "lt", english_name: "Lithuanian" },
  { iso_639_1: "hr", english_name: "Croatian" },
  { iso_639_1: "uk", english_name: "Ukrainian" },
  { iso_639_1: "sr", english_name: "Serbian" },
  { iso_639_1: "ca", english_name: "Catalan" },
  { iso_639_1: "sl", english_name: "Slovene" },
  { iso_639_1: "lv", english_name: "Latvian" },
  { iso_639_1: "et", english_name: "Estonian" },
  { iso_639_1: "hi", english_name: "Hindi" },
  { iso_639_1: "bn", english_name: "Bengali" }, # id:  40
  { iso_639_1: "tl", english_name: "Tagalog" },
  { iso_639_1: "uz", english_name: "Uzbek" },
  { iso_639_1: "af", english_name: "Afrikaans" },
  { iso_639_1: "ur", english_name: "Urdu" },
  { iso_639_1: "be", english_name: "Belarusian" },
  { iso_639_1: "ga", english_name: "Irish" },
  { iso_639_1: "bs", english_name: "Bosnian" },
  { iso_639_1: "kk", english_name: "Kazakh" },
  { iso_639_1: "az", english_name: "Azerbaijani" },
  { iso_639_1: "si", english_name: "Sinhalese" },  # id:  50
  { iso_639_1: "ka", english_name: "Georgian" },
  { iso_639_1: "ky", english_name: "Kyrgyz" },
  { iso_639_1: "mk", english_name: "Macedonian" },
  { iso_639_1: "tg", english_name: "Tajik" },
  { iso_639_1: "mn", english_name: "Mongolian" },
  { iso_639_1: "tk", english_name: "Turkmen" }
]

users = [
  # temp mails
  { email: 'chinczyk-123qwe@yopmail.com', password: "123qweasd"  },   # id 1
  { email: 'polak-123qwe@yopmail.com', password: "123qweasd"  },      # id 2
  { email: 'arab-123qwe@yopmail.com', password: "123qweasd"  },       # id 3
  { email: 'amerykanin-123qwe@yopmail.com', password: "123qweasd"  }, # id 4
  { email: 'anglik-123qwe@yopmail.com', password: "123qweasd"  },     # id 5
  { email: 'fin-123qwe@yopmail.com', password: "123qweasd"  },        # id 6
  { email: 'hiszpan-123qwe@yopmail.com', password: "123qweasd"  }     # id 7
]

Language.create(languages)
User.create(users)

profiles = [
  { user_id: 1, description: "Ni hao", color: '#dddd11'  },   # id 1
  { user_id: 2, description: "siema kto pl", color: '#111111'  },   # id 2
  { user_id: 3, description: "allah akbar, bum! kill all, isis good, more social for me", color: '#11dd11'  },   # id 3
  { user_id: 4, description: "hello", color: '#1111dd'  },   # id 4
  { user_id: 5, description: "hi", color: '#5525dd'  },   # id 5
  { user_id: 6, description: "suomi", color: '#8888ff'  },   # id 6
  { user_id: 7, description: "hola", color: '#ee1143'  },   # id 7
]

Profile.create profiles

profile_name_edits = [
  { profile_id: 1, name: "Sun_Tzu"  },   # id 1
  { profile_id: 2, name: "pantherSS-88"  },   # id 2
  { profile_id: 3, name: "Saladin"  },   # id 3
  { profile_id: 4, name: "Patton"  },   # id 4
  { profile_id: 5, name: "Wellington"  },   # id 5
  { profile_id: 6, name: "Suomi"  },   # id 6
  { profile_id: 7, name: "Matador"  },   # id 7

]

ProfileNameEdit.create profile_name_edits
