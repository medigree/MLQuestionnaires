Alias: $SCT = http://snomed.ct/info
Alias: $translation = http://hl7.org/fhir/StructureDefinition/translation




RuleSet: AddTranslation(context, language, content)
* {context}.extension[+].url = $translation
* {context}.extension[=].extension[0].url = "lang"
* {context}.extension[=].extension[0].valueCode = #{language}
* {context}.extension[=].extension[1].url = "content"
* {context}.extension[=].extension[1].valueString = {content}


RuleSet: Question(linkId, text, type, required, repeats)
* item[+].linkId = "{linkId}"
* item[=].text = "{text}"
* item[=].type = #{type}
* item[=].required = {required}
* item[=].repeats = {repeats}

RuleSet: Translation(language, text)
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/translation"
* extension[=].extension[+].url = "lang"
* extension[=].extension[=].valueCode = #{language}
* extension[=].extension[+].url = "content"
* extension[=].extension[=].valueString = "{text}"


/*
Instance: questionnaire-ee
InstanceOf: Questionnaire
Description: "Product data entry form"
Title:    "Product data entry form"
* identifier[0].system = "http://www.ee.org"
* identifier[0].value = "questionnaire-ee"
* name = "questionnaire-ee"

* title = "Product attributes"
* title
  * insert Translation(fr,Données du produit)
* status = #active

* insert Question(,MedicinalProduct,Product,group,false,true)
* item[=]
  * text 
    * insert Translation(fr,Produit)
  * insert Question(,identifier,Identifier,group,false,true)
  * item[=]
    * text 
      * insert Translation(fr,identifiant produit)
    * insert Question(,identifier_system,System,string,true,false)
    * item[=]
      * text 
        * insert Translation(fr,système d'identification)//'
    * insert Question(,identifier_value,Value,string,true,false)
    * item[=]
      * text 
        * insert Translation(fr,identifiant)

*/
/*


RuleSet: VSCodeDef(system,code,display)
* expansion.contains[+].system = {system} 
* expansion.contains[=].code = #{code}
* expansion.contains[=].display = "{display}"


Instance: FoodAllergyVS-cont
InstanceOf: ValueSet
Description: "Food Allergy ValueSet"
Title: "Food Allergy ValueSet"
Usage: #inline
* name = "FoodAllergyVS"
* id = "vs-food-allergy-cont"
* status = #active
* expansion.timestamp = "2022-01-27"
* insert VSCodeDef($SCT,91935009,Allergy to peanut)
* insert VSCodeDef($SCT,48821000119104,Allergy to tree nut)
* insert VSCodeDef($SCT,782555009,Allergy to cow’s milk protein)
* insert VSCodeDef($SCT,213020009,Allergy to egg protein)
* insert VSCodeDef($SCT,417532002,Allergy to fish)
* insert VSCodeDef($SCT,300913006,Allergy to shellfish)
* insert VSCodeDef($SCT,782594005,Allergy to soy protein)
* insert VSCodeDef($SCT,260167008,Sesame seed) // note that this is not the correct code – one couldn’t be found
* insert VSCodeDef($SCT,21191000122102,Allergy to mustard)
* insert VSCodeDef($SCT,712843002,Allergy to celery)
* insert VSCodeDef($SCT,782575000,Allergy to lupine seed)


Instance: FoodAllergyVerificationStatusVS-cont
InstanceOf: ValueSet
Description: "Food Allergy verification status ValueSet"
Title: "Food Allergy verification status ValueSet"
Usage: #inline
* name = "FoodAllergyVerificationStatusVS"
* id = "vs-food-allergy-verifstatus-cont"
* status = #active
* expansion.timestamp = "2022-01-27"
* insert VSCodeDef($SCT,410605003,Confirmed present)
* insert VSCodeDef($SCT,415684004,Suspected)


Instance: FoodAllergyClinicalStatusVS-cont
InstanceOf: ValueSet
Description: "Food Allergy clinical status ValueSet"
Title: "Food Allergy clinical status ValueSet"
Usage: #inline
* name = "FoodAllergyVS"
* id = "vs-food-allergy-clinstatus-cont"
* status = #active
* expansion.timestamp = "2022-01-27"
* insert VSCodeDef($SCT,723506003,Resolved)
* insert VSCodeDef($SCT,55561003,Active)





Instance: food-allergy-questionnaire
//InstanceOf: sdc-questionnaire-extract
InstanceOf: Questionnaire
Description: "Self-reported food allergy Form"
Title: "Self-reported food allergy Form"
Usage: #definition

* contained[+] = FoodAllergyVS-cont
* contained[+] = FoodAllergyVerificationStatusVS-cont
* contained[+] = FoodAllergyClinicalStatusVS-cont



* title = "Food Allergy self-report"
* title
  * insert Translation(fr,Déclaration d'allergies) //'


* description = "A form for self-reported food allergies, including the basic information and contained valuesets"
* name = "FoodAllergyQuestionnaire"
* version = "2022"
* status = #draft
* subjectType = #Patient
* language = #en
* status = #draft

* url = "http://openhie.org/fhir/food-allergy/Questionnaire/food-allergy-questionnaire"

* item[+].linkId = "title"
* item[=].text = "Food Allergy report"
* item[=].type = #display
* item[+].linkId = "instructions"
* item[=].text = "Reporting instructions: Please report any allergy or allergic reaction"
* item[=].type = #display


* insert Question(,patient,Patient ID,string,false)
* item[=]
  * text 
    * insert Translation(fr,ID du patient)

* insert Question(,allergen,Substance that the person is allergic to,choice,false)
* item[=].text 
  * insert Translation(fr,Sustance à laquelle la personne est allergique)

* item[=].answerValueSet = Canonical(vs-food-allergy-cont)
* item[=].text 
  * insert Translation(fr,Sustance à laquelle la personne est allergique)

* insert Question(,clinicalStatus,Status of the allergy - active or resolved,choice,false)
* item[=].text 
  * insert Translation(fr,Status de l'allergie - active, résolue) //'
* item[=].answerValueSet = Canonical(vs-food-allergy-clinstatus-cont)
* insert Question(,verificationStatus,Verification status of the allergy - confirmed or suspected or refuted,choice,false)
* item[=].text 
  * insert Translation(fr,...) //'
* item[=].answerValueSet = Canonical(vs-food-allergy-verifstatus-cont)
* insert Question(,recordedDate,When was it reported,date,false)
* item[=].text 
  * insert Translation(fr,...) //'
* insert Question(,recorder,Who recorded the allergy,string,false)
* item[=].text 
  * insert Translation(fr,...) //'
* insert Question(,asserter,Who asserted the allergy,string,false)
* item[=].text 
  * insert Translation(fr,...) //'
* insert Question(,reactions,Reactions,group,false)
* item[=].text 
  * insert Translation(fr,...) //'
* insert Question(item[=].,substance,Substance that is thought to have triggered the reaction,string,false)
* item[=].item[=].text 
  * insert Translation(fr,...) //'
* insert Question(item[=].,manifestation,Manifestation,string,false)
* item[=].item[=].text 
  * insert Translation(fr,...) //'
//  * certitude 0..1 CodeableConcept "How certain we are that the cause of the reaction was the allergen indicated" "How certain we are that the cause of the reaction was the allergen indicated"
//  * exposure 0..1 CodeableConcept "The exposure route to the substance" "The exposure route to the substance"
* insert Question(item[=].,note,Note,string,false)
* item[=].item[=].text 
  * insert Translation(fr,...) //'


*/



Instance: allergy-intolerance-questionnaire
InstanceOf: Questionnaire
Description: "Questionnaire for Allergy / Intolerance reporting"
Title: "Questionnaire for Allergy / Intolerance reporting"
* name = "AllergyIntoleranceQuestionnaire"
* title = "Allergy / Intolerance reporting Questionnaire"
* insert AddTranslation(title,fr-BE,"Déclaration d'allergies")
* insert AddTranslation(title,nl-BE,"")

* version = "2020"
* status = #draft
* subjectType = #Patient
* language = #en
* status = #draft

//* contained[+] = Canonical("https://www.ehealth.fgov.be/standards/fhir/ValueSet/be-exposureroute")
//* contained[+] = Canonical("https://www.ehealth.fgov.be/standards/fhir/ValueSet/be-riskmanifestation")

* insert Question(patient,Patient,group,false,false)
* item[=]
  * insert AddTranslation(text,fr-BE,"Patient")
  * insert AddTranslation(text,nl-BE,"Patient")
  * required = true
  * insert Question(patient-name,Patient Name,string,false,false)
  * item[=]
    * insert AddTranslation(text,fr-BE,"Nom du patient")  
    * insert AddTranslation(text,nl-BE,".")
  * insert Question(patient-id,Patient ID,string,false,false)
  * item[=]
    * insert AddTranslation(text,fr-BE,"ID du patient")
    * insert AddTranslation(text,nl-BE,"Patiënt ID")

* insert Question(status,AllergyStatus,display,false,false)
* item[=]
  * insert Question(clinical-status,Clinical Status,string,false,false)
  * item[=]
    * insert AddTranslation(text,fr-BE,"Status clinique")
    * insert AddTranslation(text,nl-BE,".")
  * answerOption[+]
    * valueCoding = #active "Active"
    * insert AddTranslation(valueCoding.display,fr-BE,"Active")
    * insert AddTranslation(valueCoding.display,nl-BE,".")
  * answerOption[+]
    * valueCoding = #inactive "Inactive"
    * insert AddTranslation(valueCoding.display,fr-BE,"Inactive")
    * insert AddTranslation(valueCoding.display,nl-BE,".")
  * answerOption[+].
    * valueCoding = #resolved "Resolved"
    * insert AddTranslation(valueCoding.display,fr-BE,"Résolue")
    * insert AddTranslation(valueCoding.display,nl-BE,".")


  * insert Question(verification-status,Verification Status,string,false,false)
  * item[=]
    * insert AddTranslation(text,fr-BE,"État de vérification")
    * insert AddTranslation(text,nl-BE,".")


  * answerOption[+]
    * valueCoding = #unconfirmed "Unconfirmed"
    * insert AddTranslation(valueCoding.display,fr-BE,"Non confirmée")
    * insert AddTranslation(valueCoding.display,nl-BE,".")
  * answerOption[+]
    * valueCoding = #confirmed "Confirmed"
    * insert AddTranslation(valueCoding.display,fr-BE,"Confirmée")
    * insert AddTranslation(valueCoding.display,nl-BE,".")
  * answerOption[+]
    * valueCoding = #refuted "Refuted"
    * insert AddTranslation(valueCoding.display,fr-BE,"Refutée")
    * insert AddTranslation(valueCoding.display,nl-BE,".")
  * answerOption[+]
    * valueCoding = #entered-in-error "entered-in-error"
    * insert AddTranslation(valueCoding.display,fr-BE,"Erreur de saisie")
    * insert AddTranslation(valueCoding.display,nl-BE,".")


* insert Question(allergyintolerance,Allergy or Intolerance?,choice,false,false)
* item[=]
  * insert AddTranslation(text,fr-BE,"Allergie ou Intolérance")
  * insert AddTranslation(text,nl-BE,".")
  * extension[0].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * extension[0].valueCodeableConcept = http://hl7.org/fhir/questionnaire-item-control#radio-button

  * answerOption[+]
    * valueCoding = #allergy "Allergy"
    * insert AddTranslation(valueCoding.display,fr-BE,"Allergie")
    * insert AddTranslation(valueCoding.display,nl-BE,".")

  * answerOption[+] 
    * valueCoding = #intolerance "Intolerance"
    * insert AddTranslation(valueCoding.display,fr-BE,"Intolérance")
    * insert AddTranslation(valueCoding.display,nl-BE,".")

* insert Question(type,Type (food\, medication\, environment\, biologic\)?,choice,false,false)
* item[=]
  * insert AddTranslation(text,fr-BE,"Médicament")
  * insert AddTranslation(text,nl-BE,".")
  * answerOption[+]
    * valueCoding = #food "Food allergy"
    * insert AddTranslation(valueCoding.display,fr-BE,"Allergie alimentaire")
    * insert AddTranslation(valueCoding.display,nl-BE,".")
  * answerOption[+]
    * valueCoding = #medication "Medication allergy or intolerance"
    * insert AddTranslation(valueCoding.display,fr-BE,"Allergie médicamenteuse")
    * insert AddTranslation(valueCoding.display,nl-BE,".")
  * answerOption[+]
    * valueCoding = #environment "Environmental allergy or intolerance"
    * insert AddTranslation(valueCoding.display,fr-BE,"Allergie environmentale")
    * insert AddTranslation(valueCoding.display,nl-BE,".")
  * answerOption[+]
    * valueCoding = #biologic "Biologic allergy or intolerance"
    * insert AddTranslation(valueCoding.display,fr-BE,"Allergie ou intolérance biologique")
    * insert AddTranslation(valueCoding.display,nl-BE,".")

* insert Question(code,Code of the allergen or substance?,choice,false,false)
* item[=]
  * answerValueSet = Canonical(BeAllergyIntoleranceCode)





* insert Question(recorded,Recorded,group,false,false)
* item[=]
  * insert AddTranslation(text,fr-BE,"Saisie")
  * insert AddTranslation(text,nl-BE,".")
  * required = true
* insert Question(recorded-date,Date of Record,date,false,false)
* item[=]
  * insert AddTranslation(text,fr-BE,"Date de saisie")
  * insert AddTranslation(text,nl-BE,".")
* insert Question(recorder,Recorder,string,false,false)
* item[=]
  * insert AddTranslation(text,fr-BE,"Enregistreur")
  * insert AddTranslation(text,nl-BE,".")
* insert Question(asserter,Asserter,string,false,false)
* item[=]
  * insert AddTranslation(text,fr-BE,"Rapporteur")
  * insert AddTranslation(text,nl-BE,".")

* insert Question(note,Note,text,true,false)
* item[=]
  * insert AddTranslation(text,fr-BE,"Note")
  * insert AddTranslation(text,nl-BE,".")

* insert Question(reactions,Reaction,group,true,false)
* item[=]
  * insert AddTranslation(text,fr-BE,"Réaction")
  * insert AddTranslation(text,nl-BE,".")
  * insert Question(manifestation,Manifestation,choice,false,false)
  * item[=]
    * insert AddTranslation(text,fr-BE,"Maniféstation")
    * insert AddTranslation(text,nl-BE,".")
    * answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/ValueSet/be-riskmanifestation"

  * insert Question(exposure-route,Exposure Route,choice,false,false)
  * item[=]
    * insert AddTranslation(text,fr-BE,"Route d'éxposition")
    * insert AddTranslation(text,nl-BE,".")
    * answerValueSet = "https://www.ehealth.fgov.be/standards/fhir/ValueSet/be-exposureroute"

  * insert Question(note,Note,choice,false,false)
  * item[=]
    * insert AddTranslation(text,fr-BE,"Note")
    * insert AddTranslation(text,nl-BE,".")


ValueSet: BeAllergyIntoleranceCode
Id: be-allergyintolerancecode
Description: "Codes as communicated by NIHDI and the FOD Terminology Center differentiating types of allergy intolerance codes. This valueset supports the Belgian federal FHIR profiling effort."
* ^version = "1.0.0"
* ^status = #active
* ^publisher = "eHealth Platform"
* ^contact.name = "eHealth Platform"
* ^contact.telecom.system = #url
* ^contact.telecom.value = "https://www.ehealth.fgov.be/standards/kmehr/en"
* include codes from valueset be-causativeagent
