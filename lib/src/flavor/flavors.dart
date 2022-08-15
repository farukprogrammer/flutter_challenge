import 'package:flutter/material.dart';

import 'flavor_config.dart';

final development = FlavorConfig(
  name: 'Development',
  baseUrl: 'https://gutendex.com',
  supportedLocales: const <Locale>[
    Locale('en', 'US'),
    Locale('ja', ''), // for japanese
    Locale('id', 'ID'), // for indonesia
  ],
);

final staging = FlavorConfig(
  name: 'Staging',
  baseUrl: 'https://gutendex.com',
  supportedLocales: const <Locale>[
    Locale('en', 'US'),
    Locale('ja', ''), // for japanese
    Locale('id', 'ID'), // for indonesia
  ],
);

final production = FlavorConfig(
  name: 'Production',
  baseUrl: 'https://gutendex.com',
  supportedLocales: const <Locale>[
    Locale('en', 'US'),
    Locale('ja', ''), // for japanese
    Locale('id', 'ID'), // for indonesia
  ],
);
