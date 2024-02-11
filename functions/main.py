from firebase_functions import firestore_fn
from firebase_admin import initialize_app, firestore
from functions_framework import CloudEvent

app = initialize_app()


@firestore_fn.on_document_written(document="mentee_Q/{mentee_id}")
def match(event: firestore_fn.Event[firestore_fn.DocumentSnapshot | None]) -> None:
    db = firestore.client()
    mentors = db.collection("mentor_Q").stream()
    # mentees = db.collection("mentee_Q").get("")
    mentee = event.data.after
    for mentor in mentors:
        print(f"Checking {mentee.id} and {mentor.id}")
        print(f"Mentee: {mentee.to_dict()['assistanceType']}, Mentor: {mentor.to_dict()['assistanceType']}")
        if mentee.to_dict()['assistanceType'] == mentor.to_dict()['assistanceType'] or mentee.to_dict()['assistanceType'] == "Other" and mentor.to_dict()['assistanceType'] == "General":
            print(f"Match found between {mentee.id} and {mentor.id}")
            db.collection(f"Matches_{mentor.id}").document(mentee.id).set({"isMatch": "yes"})
        else:
            db.collection(f"Matches_{mentor.id}").document(mentee.id).set({"isMatch": "no"})






    # if event.data is None:
    #     return
    # db = firestore.client()
    # # Extract fields with a default value to handle missing data gracefully
    # type = event.data.get("assistanceType", "")
    # issues = event.data.get("issuesDescription", "")
    # lgbtqia = event.data.get("lgbtqiaPlusMember", False)
    # life = event.data.get("lifeThreateningSituation", False)
    # previous = event.data.get("previousAssistance", False)

    # # Query for potential matches based on assistanceType to improve efficiency
    # doc_ref = db.collection("mentor_Q").stream()
    # for doc in doc_ref:
    #     if doc.get("assistanceType") == type:
    #         collection_path = f"/Match_{doc.id}"
    #         db.collection(collection_path).document(event.id).set(event.data)


    # for doc in potential_matches:
    #     # Assuming the logic for a "match" is based solely on assistanceType for this example
    #     match_id = f"{event.id}_{doc.id}"  # Example structured ID for a match document
    #     match_data = {
    #         "menteeID": event.id,
    #         "mentorID": doc.id,
    #         # Include other relevant match details or metadata here
    #     }
    #     db.collection("Matches").document(match_id).set(match_data)

