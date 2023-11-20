import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/Utils/wallet_button.dart';

class WallettScreen extends StatefulWidget {
  const WallettScreen({Key? key}) : super(key: key);

  @override
  State<WallettScreen> createState() => _WallettScreenState();
}

class _WallettScreenState extends State<WallettScreen> {
  @override
  Widget build(BuildContext context) {
    double rowSpacingHeight = 16.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF97CD9A),
        title: Text('Wallet'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Total Balance',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.ubuntu.toString(),
                      color: Colors.grey.shade200),
                )),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '60570.00  RS',
                  style: TextStyle(
                      fontSize: 24, fontFamily: GoogleFonts.ubuntu.toString()),
                )),
            SizedBox(
              height: 50,
            ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(
                  width: 0,
                  color: Colors.transparent), // Add borders to the table
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Center(
                          child: Text(
                        'Project',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: GoogleFonts.ubuntu.toString(),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(
                        'Sender',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: GoogleFonts.ubuntu.toString(),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(
                        'DATE',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: GoogleFonts.ubuntu.toString(),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(
                        'Amount',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: GoogleFonts.ubuntu.toString(),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Center(
                          child: Text(
                        'Promotion',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.ubuntu.toString()),
                      )),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(
                        'Ahmad',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.ubuntu.toString()),
                      )),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(
                        '23/4',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.ubuntu.toString()),
                      )),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(
                        '35k',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.ubuntu.toString()),
                      )),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Center(
                          child: Text(
                        'Project',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.ubuntu.toString()),
                      )),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(
                        'Zain',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.ubuntu.toString()),
                      )),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(
                        '01/02',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.ubuntu.toString()),
                      )),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(
                        '14k',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.ubuntu.toString()),
                      )),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Center(
                          child: Text(
                        'Project',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.ubuntu.toString()),
                      )),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(
                        'Zain',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.ubuntu.toString()),
                      )),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(
                        '01/02',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.ubuntu.toString()),
                      )),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(
                        '14k',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.ubuntu.toString()),
                      )),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                    SizedBox(
                        height: rowSpacingHeight), // Add space between rows
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Center(child: Text('Project')),
                    ),
                    TableCell(
                      child: Center(child: Text('Zain')),
                    ),
                    TableCell(
                      child: Center(child: Text('01/02')),
                    ),
                    TableCell(
                      child: Center(child: Text('14k')),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WalletButton(
                  image: 'assets/images/bank.png',
                  text: 'Bank Transfer',
                ),
                WalletButton(
                  image: 'assets/images/purse.png',
                  text: 'Local    Wallet',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
