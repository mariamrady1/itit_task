
import 'package:flutter/material.dart';

class DevAndUs extends StatelessWidget {

   DevAndUs({Key? key,required this.isDeveloper}) : super(key: key);
  bool isDeveloper ;
  String aboutUs = '''
  On a cold winter morning, the snow-covered landscape sparkled like diamonds under the early morning sun. The trees stood tall and bare, their branches laden with glistening frost. In the distance, a group of deer roamed gracefully, leaving delicate footprints in the powdery snow.

As the day progressed, the winter wonderland came to life with the joyful laughter of children building snowmen and engaging in snowball fights. The air was filled with excitement and the promise of fun-filled adventures in the snow.

In the heart of the town, the bustling market square was adorned with twinkling lights and festive decorations. Shoppers bustled from one stall to another, searching for unique gifts and seasonal treats. The aroma of roasted chestnuts and warm cinnamon filled the air, making everyone's mouths water.

Meanwhile, in a cozy café nearby, friends gathered around a crackling fireplace, sipping hot cocoa and sharing stories. The soft hum of conversation and the clinking of cups created an ambiance of warmth and camaraderie.

As the sun set, the sky painted a breathtaking canvas of oranges, pinks, and purples. The moon emerged, casting a soft, silvery glow over the serene landscape. The stars twinkled above, like diamonds scattered across a velvet sky.

In the distant forest, a lone wolf let out a haunting howl, its voice echoing through the night. The hooting of an owl added to the mystical atmosphere, as if nature itself was putting on a grand, enchanting performance.

Inside cozy homes, families gathered around dinner tables, feasting on hearty meals and sharing stories of their day. The crackling fireplaces provided a sense of comfort and refuge from the chilly night.

As the night wore on, the town gradually fell into a peaceful slumber, blanketed by the hush of falling snow. The world outside turned into a dreamlike landscape, where everything seemed to be bathed in a soft, magical glow.

In this winter wonderland, each moment was filled with wonder and enchantment. From the joyous laughter of children to the quiet serenity of the night, every aspect of the day seemed to be touched by a touch of magic. It was a season of warmth, togetherness, and celebration—a time to cherish the beauty of nature and the joy of being surrounded by loved ones.
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isDeveloper ?'Developers':'About Us'
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Text(
              isDeveloper
                  ? '1- Mariam Rady'
                  : aboutUs,
              style:  TextStyle(
                fontSize: isDeveloper ? 25 : 18,
                fontWeight: FontWeight.bold ,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
