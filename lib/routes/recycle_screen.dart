import 'package:flutter/material.dart';

class StepsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('How to Recyle plastic?'),
        ),
        body: ContainerPaddingExample(),
      
    );
  }
}

class ContainerPaddingExample extends StatelessWidget {
  List heading = [
    "Planters or Herb Gardens",
    "Bird Feeders",
    "Storage Containers",
    "Watering Cans",
    "Lamp Shades",
    "Eco-Bricks",
  ];

  List desc = [
    "Cut the bottom part of plastic bottles to create small planters for herbs, succulents, or small flowers. You can paint them or wrap them with rope or fabric to make them more decorative. Hang them vertically to create a space-saving vertical garden.",
    "Cut out sections of the bottle and fill it with birdseed to create a simple bird feeder. You can add perches using wooden dowels or pencils for the birds to stand on.",
    "Cut the top off plastic bottles to create storage containers for small items like buttons, pins, or craft supplies. Decorate the outside to match your room or workspace.",
    "Puncture holes in the lid of a plastic bottle to create a makeshift watering can for your plants. It's a simple way to repurpose bottles and can be very useful for gentle watering.",
    "With a bit of creativity, you can cut and assemble plastic bottles into an intricate chandelier or lampshade. This project might require multiple bottles and some additional materials like a lamp kit and strong adhesive.",
    "Fill bottles tightly with non-biodegradable waste materials (like plastic wrappers) to create eco-bricks. These bricks can be used to build small structures or furniture. It's a way to compact waste and prevent it from going to the landfill."
  ];

  List imgs = [
    "planters.png",
    "bird-feeder.png",
    "storage.png",
    "cans.png",
    "lamps.png",
    "bricks.png"
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 containers per row
        crossAxisSpacing: 10, // Horizontal space between containers
        mainAxisSpacing: 10, // Vertical space between containers
        childAspectRatio: 1.3
      ),
      itemCount: heading.length, // Total number of containers
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  '${index + 1}. ${heading[index]}',
                  style: const TextStyle(
                    fontSize: 30, // Large font number
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${desc[index]}', // Small text on the right
                style: const TextStyle(
                  fontSize: 16, // Normal font
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset("assets/images/${imgs[index]}",))
            ],
          ),
        );
      },
    );
  }
}