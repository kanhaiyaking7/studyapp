

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Providers/path_provier/data_model.dart';

final Path_data = StateNotifierProvider<PathNotifier,DataModel>((ref) {
  return PathNotifier();
});

class PathNotifier extends StateNotifier<DataModel>{
  PathNotifier():super(DataModel(data:
  {
    "Learn_newword": [
      {
        "new_word": "Curious",
        "hindi_mean": "जिज्ञासु",
        "Sentence": [
          "बच्चा बहुत जिज्ञासु है।",
          "वह हर चीज़ के बारे में जानना चाहता है।"

        ]
      },
      {
        "new_word": "Grateful",
        "hindi_mean": "आभारी",
        "Sentence": [
          "मैं आपकी मदद के लिए आभारी हूँ।",
          "हमें हमेशा आभारी रहना चाहिए।"
        ]
      }
    ],
    "choose_correct_sentence": [
      {
        "hind_Sentence": "वह कल आया था।",
        "english_sentence": [
          "He come yesterday.",
          "He came yesterday.",
          "He comes yesterday.",
          "He is come yesterday."
        ],
        "corr_sentence": "He came yesterday."
      },
      {
        "hind_Sentence": "तुम क्या कर रहे हो?",
        "english_sentence": [
          "What you are doing?",
          "What are you doing?",
          "What is you doing?",
          "What doing you are?"
        ],
        "corr_sentence": "What are you doing?"
      }
    ],
    "complete_eng_sentence": [
      {
        "english_word": "It _ raining outside.",
        "hindi_mean": "बाहर बारिश हो रही है।",
        "opt": [
          "is",
          "are"
        ],
        "corr_ans": "is"
      },
      {
        "english_word": "She _ to the market.",
        "hindi_mean": "वह बाज़ार गई।",
        "opt": [
          "go",
          "went"
        ],
        "corr_ans": "went"
      }
    ],
    "complete_hindi_sentence": [
      {
        "hindi_word": "मैं ___ रहा हूँ।",
        "english_mean": "I am eating.",
        "opt": [
          "खा",
          "सो"
        ],
        "corr_ans": "खा"
      },
      {
        "hindi_word": "वह ___ पढ़ती है।",
        "english_mean": "She reads a book.",
        "opt": [
          "किताब",
          "गाना"
        ],
        "corr_ans": "किताब"
      }
    ],
    "Speaking_word": [
      {
        "english_word": "Hello",
        "hindi_mean": "नमस्ते"
      },
      {
        "english_word": "Thank you",
        "hindi_mean": "धन्यवाद"
      }
    ]
  }
  , Level: 1));

  void update_data( dot,int value){
    state = state.copyWith(data: dot,Level: value);
  }

    }