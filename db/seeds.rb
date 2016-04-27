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
  { user_id: 1, name: "Sun_Tzu", description: "Ni hao", color: '#dddd11'  },   # id 1
  { user_id: 2, name: "pantherSS-88", description: "siema kto pl", color: '#111111'  },   # id 2
  { user_id: 3, name: "Saladin", description: "allah akbar, bum! kill all, isis good, more social for me", color: '#11dd11'  },   # id 3
  { user_id: 4, name: "Patton", description: "hello", color: '#1111dd'  },   # id 4
  { user_id: 5, name: "Wellington", description: "hi", color: '#5525dd'  },   # id 5
  { user_id: 6, name: "Suomi", description: "suomi", color: '#8888ff'  },   # id 6
  { user_id: 7, name: "Matador", description: "hola", color: '#ee1143'  },   # id 7
]

Profile.create profiles

native_languages = [7, 10, 14, 1, 1, 26, 5]
native_lan_index = 0
Profile.all.each do |profile|
  profile.languages << Language.find(native_languages[native_lan_index])
  native_lan_index += 1
end

# game id 1
Game.create(full_name: 'The Battle for Wesnoth',
            short_name: 'Wesnoth',
            description: 'The Battle for Wesnoth is a Free, turn-based tactical strategy game with a high fantasy theme, featuring both single-player, and online/hotseat multiplayer combat. More on www.wesnoth.org',
            simultaneous_turns: false)

# ladder id 1
Ladder.create(name: 'Wesnoth Blitz Test Ladder',
            description: 'This is fake Ladder. All results are fake here',
            game_id: 1)

# faction id 1
Faction.create(full_name: 'Drakes',
            short_name: 'Drakes',
            description: 'The Drakes are a faction of dragon-like Drakes and their lizard Saurian allies. Drakes are descendants of dragons, but smaller in size. Saurians are far smaller and from different ancestry. Together, the Drake faction has high mobility but low defense, leading to unusual tactics for a Default faction.',
            scenario_dependent: false,
            game_id: 1)

# faction id 2
Faction.create(full_name: 'Knalgan Alliance',
            short_name: 'Knalgan Alliance',
            description: 'The Knalgan Alliance is a faction of Dwarves and their outlaw Human allies. Dwarves are an old race who live underground and have tough, but short, warriors. The outlaws are humans who are not socially acceptable among others of their race, but have become allies of the dwarves due to common enemies. This leads to a combination of tough and defensive dwarves who are only good on certain terrain and humans who can cover ground that dwarves are not good at fighting in.',
            scenario_dependent: false,
            game_id: 1)

# faction id 3
Faction.create(full_name: 'Loyalists',
            short_name: 'Loyalists',
            description: 'The Loyalists are a faction of Humans who are loyal to the throne of Wesnoth. Humans are a versatile race who specialize in many different areas. Similarly, the Loyalist faction is a very versatile melee-oriented faction with important ranged support from bowmen and mages.',
            scenario_dependent: false,
            game_id: 1)

# faction id 4
Faction.create(full_name: 'Northerners',
            short_name: 'Northerners',
            description: 'The Northerners are a faction of Orcs and their allies who live in the north of the Great Continent, thus their name. Northerners consist of the warrior orcs race, the enslaved goblins, trolls who are tricked into combat by the orcs, and the serpentine naga. The Northerners play best by taking advantage of having many low-cost and high HP soldiers.',
            scenario_dependent: false,
            game_id: 1)

# faction id 5
Faction.create(full_name: 'Rebels',
            short_name: 'Rebels',
            description: "The Rebels are a faction of Elves and their various forest-dwelling allies. They get their human name, Rebels, from the time of Heir to the Throne, when they started the rebellion against the evil Queen Asheviere. Elves are a magical race that are masters of the bow and are capable of living many years longer than humans. In harmony with nature, the elves find allies with the human mages, certain merfolk, and tree creatures called \"Woses.\" Rebels are best played taking advantage of their high forest defense, mastery of ranged attacks, and the elves' neutral alignment.",
            scenario_dependent: false,
            game_id: 1)

# faction id 6
Faction.create(full_name: 'Undead',
            short_name: 'UndThe Undead are a faction of undead creatures and human practitioners of dark arts that usually accompany them. Often, these "Dark Adepts" are the units that do the most damage for the faction, but they have a major vulnerability - their practicing of this forbidden, evil magic has consumed all their energy and so they have no melee attack at all. The Undead are a very aggressive faction and the most powerful Default Era faction at nighttime.',
            scenario_dependent: false,
            game_id: 1)

wesnoth_factions = Faction.where(id: [1,2,3,4,5,6])

# scenario id 1
Scenario.create(full_name: 'Weldyn Channel',
                short_name: 'Weldyn Channel',
                description: 'Weldyn Channel is a map with a lake.',
                mirror_matchups_allowed: true,
                ladder_id: 1,
                map_size: nil,
                map_random_generated: false)

Scenario.find(1).factions << wesnoth_factions

# scenario id 2
Scenario.create(full_name: 'Hamlets',
                short_name: 'Hamlets',
                description: 'Hamlets is a very boring map.',
                mirror_matchups_allowed: true,
                ladder_id: 1,
                map_size: nil,
                map_random_generated: false)

Scenario.find(2).factions << wesnoth_factions

# scenario id 3
Scenario.create(full_name: 'The Freelands',
                short_name: 'The Freelands',
                description: 'The Freelands is a map with three ways to the enemy castle.',
                mirror_matchups_allowed: true,
                ladder_id: 1,
                map_size: nil,
                map_random_generated: false)

Scenario.find(3).factions << wesnoth_factions

# scenario id 4
Scenario.create(full_name: 'Caves of the Basilisk',
                short_name: 'Caves of the Basilisk',
                description: 'Caves of the Basilisk is a map.',
                mirror_matchups_allowed: true,
                ladder_id: 1,
                map_size: nil,
                map_random_generated: false)

Scenario.find(4).factions << wesnoth_factions

# scenario id 5
Scenario.create(full_name: 'Den of Onis',
                short_name: 'Den of Onis',
                description: 'Den of Onis is a map.',
                mirror_matchups_allowed: true,
                ladder_id: 1,
                map_size: nil,
                map_random_generated: false)

Scenario.find(5).factions << wesnoth_factions

# scenario id 6
Scenario.create(full_name: 'Fallenstar Lake',
                short_name: 'Fallenstar Lake',
                description: 'Fallenstar Lake is a map.',
                mirror_matchups_allowed: true,
                ladder_id: 1,
                map_size: nil,
                map_random_generated: false)

Scenario.find(6).factions << wesnoth_factions

#########

# game id 2
Game.create(full_name: 'Field of Glory',
            short_name: 'FoG',
            description: 'Field of Glory is an approachable and fun wargame system for your PC that covers the ancient and medieval worlds.',
            simultaneous_turns: false)

# ladder id 2
Ladder.create(name: 'FoG Test Ladder 500 points',
            description: 'This is fake Ladder. All results are fake here',
            game_id: 2)

# scenario id 7
Scenario.create(full_name: 'Standard Match',
                short_name: 'Match',
                description: 'The map is chosed by a plyer with the initiative.',
                mirror_matchups_allowed: true,
                ladder_id: 2,
                map_size: nil,
                map_random_generated: false)

# faction id 7
Faction.create(full_name: 'Mid-Republican Roman(later)',
            short_name: 'Mid-Republican Roman(later)',
            description: 'Lorem ipsum dolor sit amet augue. Sed sed neque. Integer mi non nisl tristique mauris enim, id lorem. Maecenas eget odio. Nunc ut tellus non urna. Phasellus tempor id, orci. Etiam at turpis et wisi. Nam turpis at arcu quis augue. Lorem ipsum dolor urna, mattis sed, luctus et turpis. Lorem ipsum erat, fringilla neque, fringilla faucibus, fermentum diam mi ornare vel, congue et, pharetra leo. Quisque sed turpis.',
            scenario_dependent: false,
            game_id: 2)

# faction id 8
Faction.create(full_name: 'Late Republican Roman',
            short_name: 'Late Republican Roman',
            description: 'Duis elementum eu, cursus arcu sed nulla eu odio et ultrices posuere ante pellentesque ipsum wisi, aliquam id, porttitor odio. Nunc sapien. Praesent in nulla id augue. Praesent scelerisque tellus consectetuer adipiscing laoreet, enim diam sit amet, vulputate ante. Morbi a nunc. Etiam sit amet quam. Sed fringilla mollis. Sed eros.',
            scenario_dependent: false,
            game_id: 2)

# faction id 9
Faction.create(full_name: 'Late Republican Roman(Brutus & Cassius)',
            short_name: 'Late Republican Roman(Brutus & Cassius)',
            description: 'Nam varius ligula. Curabitur et ultrices posuere iaculis dignissim sagittis et, posuere cubilia Curae, Phasellus vulputate et, imperdiet nunc, tempus arcu. Suspendisse et magnis dis parturient montes, nascetur ridiculus mus. Nunc gravida. In urna. Donec erat volutpat.',
            scenario_dependent: false,
            game_id: 2)

# faction id 10
Faction.create(full_name: 'Gallic(Early Lowland)',
            short_name: 'Gallic(Early Lowland)',
            description: 'Quisque neque nibh faucibus erat. Quisque in quam. Phasellus sagittis tortor et turpis. Proin dui sodales tempor. Phasellus pulvinar massa in metus. Nullam sit amet lacus. Vivamus faucibus orci elit, ut odio urna, egestas purus. Pellentesque quam ante euismod pulvinar mollis, orci luctus et malesuada fames ac lacus. Ut nonummy. Sed faucibus, quam. Nam nec tellus. Fusce et enim. Cras sed augue mi, porttitor magna.',
            scenario_dependent: false,
            game_id: 2)

# faction id 11
Faction.create(full_name: 'Gallic(Early Hill Tribes)',
            short_name: 'Gallic(Early Hill Tribes)',
            description: ' Donec eleifend et, fermentum laoreet, tortor turpis, accumsan imperdiet, risus tortor, fermentum augue. Cum sociis natoque penatibus et luctus at, suscipit dolor. Sed dignissim dolor urna orci ut tellus ac nunc. Praesent commodo volutpat ut, pellentesque accumsan.',
            scenario_dependent: false,
            game_id: 2)

# faction id 12
Faction.create(full_name: 'Gallic(Later Lowlands)',
            short_name: 'Gallic(Later Lowlands)',
            description: 'Nullam sit amet, tellus. Morbi accumsan lorem. Maecenas bibendum ac, sodales at, posuere cubilia Curae, Mauris pretium eu, pede. Aliquam sem. Donec nonummy, tellus rutrum id, lacinia dignissim. Aliquam fringilla, nibh. Donec elit. Vestibulum ante ipsum wisi, dapibus vitae, fringilla sed, pretium erat sed orci ac arcu mi ornare ornare.',
            scenario_dependent: false,
            game_id: 2)

# faction id 13
Faction.create(full_name: 'Gallic(Later Hill Tribes)',
            short_name: 'Gallic(Later Hill Tribes)',
            description: 'Cras porta, erat volutpat. Nam lorem hendrerit sed, aliquet elit. Mauris arcu. Nam dolor id tincidunt luctus. Phasellus sapien eros, varius leo. Nullam bibendum leo, aliquet eget, lacinia quis, varius in, consequat porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per conubia nostra, per inceptos hymenaeos.',
            scenario_dependent: false,
            game_id: 2)

# faction id 14
Faction.create(full_name: 'Pyrrhic',
            short_name: 'Pyrrhic',
            description: 'Lorem ipsum dolor sit amet augue. Sed sed neque. Integer mi non nisl tristique mauris enim, id lorem. Maecenas eget odio. Nunc ut tellus non urna. Phasellus tempor id, orci. Etiam at turpis et wisi. Nam turpis at arcu quis augue. Lorem ipsum dolor urna, mattis sed, luctus et turpis. Lorem ipsum erat, fringilla neque, fringilla faucibus, fermentum diam mi ornare vel, congue et, pharetra leo. Quisque sed turpis.',
            scenario_dependent: false,
            game_id: 2)

# faction id 15
Faction.create(full_name: 'Pyrrhic(in Italy)',
            short_name: 'Pyrrhic(in Italy)',
            description: 'Duis elementum eu, cursus arcu sed nulla eu odio et ultrices posuere ante pellentesque ipsum wisi, aliquam id, porttitor odio. Nunc sapien. Praesent in nulla id augue. Praesent scelerisque tellus consectetuer adipiscing laoreet, enim diam sit amet, vulputate ante. Morbi a nunc. Etiam sit amet quam. Sed fringilla mollis. Sed eros.',
            scenario_dependent: false,
            game_id: 2)

# faction id 16
Faction.create(full_name: 'Pyrrhic(in Greece)',
            short_name: 'Pyrrhic(in Greece)',
            description: 'Nam varius ligula. Curabitur et ultrices posuere iaculis dignissim sagittis et, posuere cubilia Curae, Phasellus vulputate et, imperdiet nunc, tempus arcu. Suspendisse et magnis dis parturient montes, nascetur ridiculus mus. Nunc gravida. In urna. Donec erat volutpat.',
            scenario_dependent: false,
            game_id: 2)

# faction id 17
Faction.create(full_name: 'Later Carthaginian(pre-235BC)',
            short_name: 'Later Carthaginian(pre-235BC)',
            description: 'Quisque neque nibh faucibus erat. Quisque in quam. Phasellus sagittis tortor et turpis. Proin dui sodales tempor. Phasellus pulvinar massa in metus. Nullam sit amet lacus. Vivamus faucibus orci elit, ut odio urna, egestas purus. Pellentesque quam ante euismod pulvinar mollis, orci luctus et malesuada fames ac lacus. Ut nonummy. Sed faucibus, quam. Nam nec tellus. Fusce et enim. Cras sed augue mi, porttitor magna.',
            scenario_dependent: false,
            game_id: 2)

# faction id 18
Faction.create(full_name: 'Later Carthaginian(post-235BC)',
            short_name: 'Later Carthaginian(post-235BC)',
            description: ' Donec eleifend et, fermentum laoreet, tortor turpis, accumsan imperdiet, risus tortor, fermentum augue. Cum sociis natoque penatibus et luctus at, suscipit dolor. Sed dignissim dolor urna orci ut tellus ac nunc. Praesent commodo volutpat ut, pellentesque accumsan.',
            scenario_dependent: false,
            game_id: 2)

# faction id 19
Faction.create(full_name: 'Later Carthaginian(in Africa)',
            short_name: 'Later Carthaginian(in Africa)',
            description: 'Nullam sit amet, tellus. Morbi accumsan lorem. Maecenas bibendum ac, sodales at, posuere cubilia Curae, Mauris pretium eu, pede. Aliquam sem. Donec nonummy, tellus rutrum id, lacinia dignissim. Aliquam fringilla, nibh. Donec elit. Vestibulum ante ipsum wisi, dapibus vitae, fringilla sed, pretium erat sed orci ac arcu mi ornare ornare.',
            scenario_dependent: false,
            game_id: 2)

# faction id 20
Faction.create(full_name: 'Later Carthaginian(3rd Punic)',
            short_name: 'Later Carthaginian(3rd Punic)',
            description: 'Cras porta, erat volutpat. Nam lorem hendrerit sed, aliquet elit. Mauris arcu. Nam dolor id tincidunt luctus. Phasellus sapien eros, varius leo. Nullam bibendum leo, aliquet eget, lacinia quis, varius in, consequat porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per conubia nostra, per inceptos hymenaeos.',
            scenario_dependent: false,
            game_id: 2)

# faction id 21
Faction.create(full_name: 'Illyrian',
            short_name: 'Illyrian',
            description: 'Lorem ipsum dolor sit amet augue. Sed sed neque. Integer mi non nisl tristique mauris enim, id lorem. Maecenas eget odio. Nunc ut tellus non urna. Phasellus tempor id, orci. Etiam at turpis et wisi. Nam turpis at arcu quis augue. Lorem ipsum dolor urna, mattis sed, luctus et turpis. Lorem ipsum erat, fringilla neque, fringilla faucibus, fermentum diam mi ornare vel, congue et, pharetra leo. Quisque sed turpis.',
            scenario_dependent: false,
            game_id: 2)

# faction id 22
Faction.create(full_name: 'Illyrian(common)',
            short_name: 'Illyrian(common)',
            description: 'Duis elementum eu, cursus arcu sed nulla eu odio et ultrices posuere ante pellentesque ipsum wisi, aliquam id, porttitor odio. Nunc sapien. Praesent in nulla id augue. Praesent scelerisque tellus consectetuer adipiscing laoreet, enim diam sit amet, vulputate ante. Morbi a nunc. Etiam sit amet quam. Sed fringilla mollis. Sed eros.',
            scenario_dependent: false,
            game_id: 2)

# faction id 23
Faction.create(full_name: 'Spanish(Iberian)',
            short_name: 'Spanish(Iberian)',
            description: 'Nam varius ligula. Curabitur et ultrices posuere iaculis dignissim sagittis et, posuere cubilia Curae, Phasellus vulputate et, imperdiet nunc, tempus arcu. Suspendisse et magnis dis parturient montes, nascetur ridiculus mus. Nunc gravida. In urna. Donec erat volutpat.',
            scenario_dependent: false,
            game_id: 2)

# faction id 24
Faction.create(full_name: 'Spanish(Lusitanian)',
            short_name: 'Spanish(Lusitanian)',
            description: 'Quisque neque nibh faucibus erat. Quisque in quam. Phasellus sagittis tortor et turpis. Proin dui sodales tempor. Phasellus pulvinar massa in metus. Nullam sit amet lacus. Vivamus faucibus orci elit, ut odio urna, egestas purus. Pellentesque quam ante euismod pulvinar mollis, orci luctus et malesuada fames ac lacus. Ut nonummy. Sed faucibus, quam. Nam nec tellus. Fusce et enim. Cras sed augue mi, porttitor magna.',
            scenario_dependent: false,
            game_id: 2)

# faction id 25
Faction.create(full_name: 'Spanish(Celtiberian)',
            short_name: 'Spanish(Celtiberian)',
            description: ' Donec eleifend et, fermentum laoreet, tortor turpis, accumsan imperdiet, risus tortor, fermentum augue. Cum sociis natoque penatibus et luctus at, suscipit dolor. Sed dignissim dolor urna orci ut tellus ac nunc. Praesent commodo volutpat ut, pellentesque accumsan.',
            scenario_dependent: false,
            game_id: 2)

# faction id 26
Faction.create(full_name: 'Later Macedonian',
            short_name: 'Later Macedonian',
            description: 'Nullam sit amet, tellus. Morbi accumsan lorem. Maecenas bibendum ac, sodales at, posuere cubilia Curae, Mauris pretium eu, pede. Aliquam sem. Donec nonummy, tellus rutrum id, lacinia dignissim. Aliquam fringilla, nibh. Donec elit. Vestibulum ante ipsum wisi, dapibus vitae, fringilla sed, pretium erat sed orci ac arcu mi ornare ornare.',
            scenario_dependent: false,
            game_id: 2)

# faction id 27
Faction.create(full_name: 'Attalid Pergamene',
            short_name: 'Attalid Pergamene',
            description: 'Cras porta, erat volutpat. Nam lorem hendrerit sed, aliquet elit. Mauris arcu. Nam dolor id tincidunt luctus. Phasellus sapien eros, varius leo. Nullam bibendum leo, aliquet eget, lacinia quis, varius in, consequat porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per conubia nostra, per inceptos hymenaeos.',
            scenario_dependent: false,
            game_id: 2)

# faction id 28
Faction.create(full_name: 'Numidian(Juba I)',
            short_name: 'Numidian(Juba I)',
            description: 'Cras porta, erat volutpat. Nam lorem hendrerit sed, aliquet elit. Mauris arcu. Nam dolor id tincidunt luctus. Phasellus sapien eros, varius leo. Nullam bibendum leo, aliquet eget, lacinia quis, varius in, consequat porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per conubia nostra, per inceptos hymenaeos.',
            scenario_dependent: false,
            game_id: 2)

# faction id 29
Faction.create(full_name: 'Numidian(Bogus)',
            short_name: 'Numidian(Bogus)',
            description: 'Lorem ipsum dolor sit amet augue. Sed sed neque. Integer mi non nisl tristique mauris enim, id lorem. Maecenas eget odio. Nunc ut tellus non urna. Phasellus tempor id, orci. Etiam at turpis et wisi. Nam turpis at arcu quis augue. Lorem ipsum dolor urna, mattis sed, luctus et turpis. Lorem ipsum erat, fringilla neque, fringilla faucibus, fermentum diam mi ornare vel, congue et, pharetra leo. Quisque sed turpis.',
            scenario_dependent: false,
            game_id: 2)

# faction id 30
Faction.create(full_name: 'Numidian(Juba II)',
            short_name: 'Numidian(Juba II)',
            description: 'Duis elementum eu, cursus arcu sed nulla eu odio et ultrices posuere ante pellentesque ipsum wisi, aliquam id, porttitor odio. Nunc sapien. Praesent in nulla id augue. Praesent scelerisque tellus consectetuer adipiscing laoreet, enim diam sit amet, vulputate ante. Morbi a nunc. Etiam sit amet quam. Sed fringilla mollis. Sed eros.',
            scenario_dependent: false,
            game_id: 2)

# faction id 31
Faction.create(full_name: 'Later Seleucid(pre-166BC)',
            short_name: 'Later Seleucid(pre-166BC)',
            description: 'Nam varius ligula. Curabitur et ultrices posuere iaculis dignissim sagittis et, posuere cubilia Curae, Phasellus vulputate et, imperdiet nunc, tempus arcu. Suspendisse et magnis dis parturient montes, nascetur ridiculus mus. Nunc gravida. In urna. Donec erat volutpat.',
            scenario_dependent: false,
            game_id: 2)

# faction id 32
Faction.create(full_name: 'Later Seleucid(post-166BC)',
            short_name: 'Later Seleucid(post-166BC)',
            description: 'Quisque neque nibh faucibus erat. Quisque in quam. Phasellus sagittis tortor et turpis. Proin dui sodales tempor. Phasellus pulvinar massa in metus. Nullam sit amet lacus. Vivamus faucibus orci elit, ut odio urna, egestas purus. Pellentesque quam ante euismod pulvinar mollis, orci luctus et malesuada fames ac lacus. Ut nonummy. Sed faucibus, quam. Nam nec tellus. Fusce et enim. Cras sed augue mi, porttitor magna.',
            scenario_dependent: false,
            game_id: 2)

# faction id 33
Faction.create(full_name: 'Later Ptolemaic(Greek)',
            short_name: 'Later Ptolemaic(Greek)',
            description: ' Donec eleifend et, fermentum laoreet, tortor turpis, accumsan imperdiet, risus tortor, fermentum augue. Cum sociis natoque penatibus et luctus at, suscipit dolor. Sed dignissim dolor urna orci ut tellus ac nunc. Praesent commodo volutpat ut, pellentesque accumsan.',
            scenario_dependent: false,
            game_id: 2)

# faction id 34
Faction.create(full_name: 'Later Ptolemaic(Roman)',
            short_name: 'Later Ptolemaic(Roman)',
            description: 'Nullam sit amet, tellus. Morbi accumsan lorem. Maecenas bibendum ac, sodales at, posuere cubilia Curae, Mauris pretium eu, pede. Aliquam sem. Donec nonummy, tellus rutrum id, lacinia dignissim. Aliquam fringilla, nibh. Donec elit. Vestibulum ante ipsum wisi, dapibus vitae, fringilla sed, pretium erat sed orci ac arcu mi ornare ornare.',
            scenario_dependent: false,
            game_id: 2)

# faction id 35
Faction.create(full_name: 'Pontic(early)',
            short_name: 'Pontic(early)',
            description: 'Cras porta, erat volutpat. Nam lorem hendrerit sed, aliquet elit. Mauris arcu. Nam dolor id tincidunt luctus. Phasellus sapien eros, varius leo. Nullam bibendum leo, aliquet eget, lacinia quis, varius in, consequat porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per conubia nostra, per inceptos hymenaeos.',
            scenario_dependent: false,
            game_id: 2)

# faction id 36
Faction.create(full_name: 'Pontic(late)',
            short_name: 'Pontic(late)',
            description: 'Cras porta, erat volutpat. Nam lorem hendrerit sed, aliquet elit. Mauris arcu. Nam dolor id tincidunt luctus. Phasellus sapien eros, varius leo. Nullam bibendum leo, aliquet eget, lacinia quis, varius in, consequat porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per conubia nostra, per inceptos hymenaeos.',
            scenario_dependent: false,
            game_id: 2)

# faction id 37
Faction.create(full_name: 'Spartacus Slave Revolt(HF)',
            short_name: 'Spartacus Slave Revolt(HF)',
            description: 'Cras porta, erat volutpat. Nam lorem hendrerit sed, aliquet elit. Mauris arcu. Nam dolor id tincidunt luctus. Phasellus sapien eros, varius leo. Nullam bibendum leo, aliquet eget, lacinia quis, varius in, consequat porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per conubia nostra, per inceptos hymenaeos.',
            scenario_dependent: false,
            game_id: 2)

# faction id 38
Faction.create(full_name: 'Spartacus Slave Revolt(MF)',
            short_name: 'Spartacus Slave Revolt(MF)',
            description: 'Lorem ipsum dolor sit amet augue. Sed sed neque. Integer mi non nisl tristique mauris enim, id lorem. Maecenas eget odio. Nunc ut tellus non urna. Phasellus tempor id, orci. Etiam at turpis et wisi. Nam turpis at arcu quis augue. Lorem ipsum dolor urna, mattis sed, luctus et turpis. Lorem ipsum erat, fringilla neque, fringilla faucibus, fermentum diam mi ornare vel, congue et, pharetra leo. Quisque sed turpis.',
            scenario_dependent: false,
            game_id: 2)

# faction id 39
Faction.create(full_name: 'Early Armenian(Tigran the Great)',
            short_name: 'Early Armenian(Tigran the Great)',
            description: 'Duis elementum eu, cursus arcu sed nulla eu odio et ultrices posuere ante pellentesque ipsum wisi, aliquam id, porttitor odio. Nunc sapien. Praesent in nulla id augue. Praesent scelerisque tellus consectetuer adipiscing laoreet, enim diam sit amet, vulputate ante. Morbi a nunc. Etiam sit amet quam. Sed fringilla mollis. Sed eros.',
            scenario_dependent: false,
            game_id: 2)

# faction id 40
Faction.create(full_name: 'Early Armenian(Khosrov I)',
            short_name: 'Early Armenian(Khosrov I)',
            description: 'Nam varius ligula. Curabitur et ultrices posuere iaculis dignissim sagittis et, posuere cubilia Curae, Phasellus vulputate et, imperdiet nunc, tempus arcu. Suspendisse et magnis dis parturient montes, nascetur ridiculus mus. Nunc gravida. In urna. Donec erat volutpat.',
            scenario_dependent: false,
            game_id: 2)

# faction id 41
Faction.create(full_name: 'Parthian',
            short_name: 'Parthian',
            description: 'Quisque neque nibh faucibus erat. Quisque in quam. Phasellus sagittis tortor et turpis. Proin dui sodales tempor. Phasellus pulvinar massa in metus. Nullam sit amet lacus. Vivamus faucibus orci elit, ut odio urna, egestas purus. Pellentesque quam ante euismod pulvinar mollis, orci luctus et malesuada fames ac lacus. Ut nonummy. Sed faucibus, quam. Nam nec tellus. Fusce et enim. Cras sed augue mi, porttitor magna.',
            scenario_dependent: false,
            game_id: 2)

# faction id 42
Faction.create(full_name: 'Parthian(Saka Campaign)',
            short_name: 'Parthian(Saka Campaign)',
            description: ' Donec eleifend et, fermentum laoreet, tortor turpis, accumsan imperdiet, risus tortor, fermentum augue. Cum sociis natoque penatibus et luctus at, suscipit dolor. Sed dignissim dolor urna orci ut tellus ac nunc. Praesent commodo volutpat ut, pellentesque accumsan.',
            scenario_dependent: false,
            game_id: 2)

# faction id 43
Faction.create(full_name: 'Suren Indo-Parthian',
            short_name: 'Suren Indo-Parthian',
            description: 'Nullam sit amet, tellus. Morbi accumsan lorem. Maecenas bibendum ac, sodales at, posuere cubilia Curae, Mauris pretium eu, pede. Aliquam sem. Donec nonummy, tellus rutrum id, lacinia dignissim. Aliquam fringilla, nibh. Donec elit. Vestibulum ante ipsum wisi, dapibus vitae, fringilla sed, pretium erat sed orci ac arcu mi ornare ornare.',
            scenario_dependent: false,
            game_id: 2)

# faction id 44
Faction.create(full_name: 'Hatran',
            short_name: 'Hatran',
            description: 'Cras porta, erat volutpat. Nam lorem hendrerit sed, aliquet elit. Mauris arcu. Nam dolor id tincidunt luctus. Phasellus sapien eros, varius leo. Nullam bibendum leo, aliquet eget, lacinia quis, varius in, consequat porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per conubia nostra, per inceptos hymenaeos.',
            scenario_dependent: false,
            game_id: 2)

# faction id 45
Faction.create(full_name: 'Later Jewish(Hycranus II)',
            short_name: 'Later Jewish(Hycranus II)',
            description: 'Duis elementum eu, cursus arcu sed nulla eu odio et ultrices posuere ante pellentesque ipsum wisi, aliquam id, porttitor odio. Nunc sapien. Praesent in nulla id augue. Praesent scelerisque tellus consectetuer adipiscing laoreet, enim diam sit amet, vulputate ante. Morbi a nunc. Etiam sit amet quam. Sed fringilla mollis. Sed eros.',
            scenario_dependent: false,
            game_id: 2)

# faction id 46
Faction.create(full_name: 'Later Jewish(48BC-47BC)',
            short_name: 'Later Jewish(48BC-47BC)',
            description: 'Nam varius ligula. Curabitur et ultrices posuere iaculis dignissim sagittis et, posuere cubilia Curae, Phasellus vulputate et, imperdiet nunc, tempus arcu. Suspendisse et magnis dis parturient montes, nascetur ridiculus mus. Nunc gravida. In urna. Donec erat volutpat.',
            scenario_dependent: false,
            game_id: 2)

# faction id 47
Faction.create(full_name: 'Later Jewish(Antigonus)',
            short_name: 'Later Jewish(Antigonus)',
            description: 'Quisque neque nibh faucibus erat. Quisque in quam. Phasellus sagittis tortor et turpis. Proin dui sodales tempor. Phasellus pulvinar massa in metus. Nullam sit amet lacus. Vivamus faucibus orci elit, ut odio urna, egestas purus. Pellentesque quam ante euismod pulvinar mollis, orci luctus et malesuada fames ac lacus. Ut nonummy. Sed faucibus, quam. Nam nec tellus. Fusce et enim. Cras sed augue mi, porttitor magna.',
            scenario_dependent: false,
            game_id: 2)

# faction id 48
Faction.create(full_name: 'Later Jewish',
            short_name: 'Later Jewish',
            description: ' Donec eleifend et, fermentum laoreet, tortor turpis, accumsan imperdiet, risus tortor, fermentum augue. Cum sociis natoque penatibus et luctus at, suscipit dolor. Sed dignissim dolor urna orci ut tellus ac nunc. Praesent commodo volutpat ut, pellentesque accumsan.',
            scenario_dependent: false,
            game_id: 2)

# faction id 49
Faction.create(full_name: 'Bosporan(early)',
            short_name: 'Bosporan(early)',
            description: 'Nullam sit amet, tellus. Morbi accumsan lorem. Maecenas bibendum ac, sodales at, posuere cubilia Curae, Mauris pretium eu, pede. Aliquam sem. Donec nonummy, tellus rutrum id, lacinia dignissim. Aliquam fringilla, nibh. Donec elit. Vestibulum ante ipsum wisi, dapibus vitae, fringilla sed, pretium erat sed orci ac arcu mi ornare ornare.',
            scenario_dependent: false,
            game_id: 2)

# faction id 50
Faction.create(full_name: 'Bosporan(mid)',
            short_name: 'Bosporan(mid)',
            description: 'Cras porta, erat volutpat. Nam lorem hendrerit sed, aliquet elit. Mauris arcu. Nam dolor id tincidunt luctus. Phasellus sapien eros, varius leo. Nullam bibendum leo, aliquet eget, lacinia quis, varius in, consequat porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per conubia nostra, per inceptos hymenaeos.',
            scenario_dependent: false,
            game_id: 2)

# faction id 51
Faction.create(full_name: 'Bosporan(late)',
            short_name: 'Bosporan(late)',
            description: 'Nullam sit amet, tellus. Morbi accumsan lorem. Maecenas bibendum ac, sodales at, posuere cubilia Curae, Mauris pretium eu, pede. Aliquam sem. Donec nonummy, tellus rutrum id, lacinia dignissim. Aliquam fringilla, nibh. Donec elit. Vestibulum ante ipsum wisi, dapibus vitae, fringilla sed, pretium erat sed orci ac arcu mi ornare ornare.',
            scenario_dependent: false,
            game_id: 2)

# faction id 52
Faction.create(full_name: 'Bosporan(218-284)',
            short_name: 'Bosporan(218-284)',
            description: 'Cras porta, erat volutpat. Nam lorem hendrerit sed, aliquet elit. Mauris arcu. Nam dolor id tincidunt luctus. Phasellus sapien eros, varius leo. Nullam bibendum leo, aliquet eget, lacinia quis, varius in, consequat porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per conubia nostra, per inceptos hymenaeos.',
            scenario_dependent: false,
            game_id: 2)
