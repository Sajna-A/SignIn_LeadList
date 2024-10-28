import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_list/cubit2/cubit/leadlist_cubit.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: const Text(
          'Lead List',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          const Icon(Icons.notifications, color: Colors.black),
          const SizedBox(width: 16),
        ],
      ),
      body: BlocProvider(
        create: (context) => LeadlistCubit(context),
        child: BlocBuilder<LeadlistCubit, LeadlistState>(
          builder: (context, state) {
            if (state is viewData) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.data.data!.leads!.length, // Number of items
                itemBuilder: (context, index) {
                  final lead = state.data.data!.leads![index];
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Circle with number
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    lead.id.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Main content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lead.name.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade800,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(lead.email.toString()),
                                    Text(lead.createdAt.toString()),
                                    Text(lead.mobile.toString()),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Flutter tag and call icon
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Colors.grey, size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        'Calicut',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          final cubit =
                                              context.read<LeadlistCubit>();
                                          cubit.leadlist();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade100,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            lead.interest.toString(),
                                            style: TextStyle(
                                                color: Colors.blue.shade800),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(Icons.call,
                                          color: Colors.blue.shade900),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
