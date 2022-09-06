import 'package:flutter/material.dart';

class Messenger_List extends StatelessWidget {
  const Messenger_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  'https://pbs.twimg.com/profile_images/847601753973415940/cVPQkoDI_400x400.jpg'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            child: Icon(Icons.camera_alt),
            radius: 17.0,
            backgroundColor: Colors.blue,
          ),
          SizedBox(
            width: 8.0,
          ),
          CircleAvatar(
            child: Icon(
              Icons.edit,
            ),
            radius: 17.0,
            backgroundColor: Colors.blue,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(7.0)),
                padding: EdgeInsets.all(5.0),
                child: Row(children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text('Search'),
                ]),
              ),
              SizedBox(
                height: 17.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index) => Container(
                      width: 60,
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(
                                    'https://pbs.twimg.com/profile_images/847601753973415940/cVPQkoDI_400x400.jpg'),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  bottom: 3.0,
                                  end: 3.0,
                                ),
                                child: CircleAvatar(
                                  radius: 7.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            'Mostafa Mahmoud Mohamed Tolba',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context , index )=> SizedBox(width:15.0),
                    itemCount: 20),
              ),
              ListView.separated(
                scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context , index) => Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                                'https://pbs.twimg.com/profile_images/847601753973415940/cVPQkoDI_400x400.jpg'),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              bottom: 3.0,
                              end: 3.0,
                            ),
                            child: CircleAvatar(
                              radius: 7.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mostafa Mahmoud Tolba ',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Hello My Friend How are you man and where are you ',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height: 5.0,
                                    width: 5.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Text('2:00pm'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  separatorBuilder: (context , index ) => SizedBox(height: 15.0,),
                  itemCount:20)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStoryItem() => Container(
        width: 60,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://pbs.twimg.com/profile_images/847601753973415940/cVPQkoDI_400x400.jpg'),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 3.0,
                    end: 3.0,
                  ),
                  child: CircleAvatar(
                    radius: 7.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              'Mostafa Mahmoud Mohamed Tolba',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
  Widget buildChatItem() => Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://pbs.twimg.com/profile_images/847601753973415940/cVPQkoDI_400x400.jpg'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 3.0,
                  end: 3.0,
                ),
                child: CircleAvatar(
                  radius: 7.0,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mostafa Mahmoud Tolba ',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Hello My Friend How are you man and where are you ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 5.0,
                        width: 5.0,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Text('2:00pm'),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
}
