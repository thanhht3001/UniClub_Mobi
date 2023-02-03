import 'package:flutter/material.dart';
// import '../../../models/entities/competition/competition_model.dart';
import '../../../models/entities/competition/competition_show_model.dart';
import '../../size_config.dart';
import 'section_title.dart';

class SpecialOffersCompetitionOfParticipant extends StatelessWidget {
  final List<CompetitionShowModel> outStandingEvents;

  const SpecialOffersCompetitionOfParticipant({Key? key, required this.outStandingEvents})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
          child: SectionTitleCompetitionOfParticipant(
            title: "Nổi bật",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(10)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List.generate(outStandingEvents.length, (index) {
            return SpecialOfferCard(
              image: (outStandingEvents[index])
                  .competitionEntities[0]
                  .imageUrl,
              description: '',
              name: (outStandingEvents[index]).name,
              press: () {},
            );
          })

              // [

              //   // ListView.builder(itemBuilder: (context, index) {
              //   //   return SpecialOfferCard(name: name, image: image, description: description, press: () {},)
              //   // })
              //   SpecialOfferCard(
              //     image: "assets/image/Image Banner 2.png",
              //     name: "Smartphone",
              //     description: "Data check",
              //     press: () {},
              //   ),
              //   SpecialOfferCard(
              //     image: "assets/image/Image Banner 3.png",
              //     name: "Fashion",
              //     description: "Data Cehcl",
              //     press: () {},
              //   ),
              //   SpecialOfferCard(
              //     image: "assets/image/Image Banner 3.png",
              //     name: "Fashion",
              //     description: "Data Cehcl",
              //     press: () {},
              //   ),
              //   //SizedBox(width: getProportionateScreenWidth(10)),
              // ],
              ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.name,
    required this.image,
    required this.description,
    required this.press,
  }) : super(key: key);

  final String name, image;
  final String description;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
          right: getProportionateScreenWidth(20),
          left: getProportionateScreenWidth(5)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(screenWidth / 2),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Stack(
              children: [
                (image.isNotEmpty)
                    ? Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: getProportionateScreenWidth(screenWidth / 2),
                      )
                    : SizedBox.shrink(),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$name\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$description")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
