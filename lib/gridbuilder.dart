// GridView.builder(
// gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
// maxCrossAxisExtent: 200,
// childAspectRatio: 2 / 3,
// crossAxisSpacing: 5,
// mainAxisSpacing: 5,
// ),
// itemCount: map.entries.length,
// itemBuilder: (BuildContext ctx, index) {
// return GestureDetector(
// onTap: () {
// showDialog(
// context: context,
// builder: (context) {
// return AlertDialog(
// backgroundColor: const Color(0xffFFE8D6),
// title: const Align(
// alignment: Alignment.center,
// child: Text(
// "حدد نوع الاستشارة",
// ),
// ),
// content: SizedBox(
// height: 150,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// ElevatedButton(
// onPressed: () {
// Navigator.of(context).push(
// MaterialPageRoute(
// builder: (context) =>
// const ListConsultants(),
// ),
// );
// },
// child: Text(
// "مجدولة",
// style: Theme.of(context)
//     .textTheme
//     .headline6!
//     .copyWith(
// color: Colors.white,
// ),
// ),
// ),
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// const ConsultationDetailsInstant(),
// ),
// );
// },
// child: Text(
// "فورية",
// style: Theme.of(context)
//     .textTheme
//     .headline6!
//     .copyWith(
// color: Colors.white,
// ),
// ),
// ),
// ],
// ),
// ),
// );
// },
// );
// },
// child: Container(
// child: Column(
// children: [
// Container(
// padding: const EdgeInsets.all(20),
// child: Align(
// alignment: Alignment.centerRight,
// child: Text(
// map.keys.elementAt(index),
// style: Theme.of(context)
//     .textTheme
//     .headline6!
//     .copyWith(
// color: const Color(0xff6B705C),
// height: 1.2,
// ),
// ),
// ),
// ),
// Expanded(
// child: Image.asset(
// "Assets/${map.values.elementAt(index)}",
// ),
// )
// ],
// ),
// alignment: Alignment.center,
// decoration: BoxDecoration(
// color: const Color(0xffFFE8D6),
// borderRadius: BorderRadius.circular(10),
// ),
// ),
// );
// },
// ),
