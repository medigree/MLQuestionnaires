RuleSet: Question(context, linkId, text, type, required, repeats)
* {context}item[+].linkId = "{linkId}"
* {context}item[=].text = "{text}"
* {context}item[=].type = #{type}
* {context}item[=].required = {required}
* {context}item[=].repeats = {repeats}

RuleSet: Translation(language, text)
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/translation"
* extension[=].extension[+].url = "lang"
* extension[=].extension[=].valueCode = #{language}
* extension[=].extension[+].url = "content"
* extension[=].extension[=].valueString = "{text}"



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
        * insert Translation(fr,système d'identification)
    * insert Question(,identifier_value,Value,string,true,false)
    * item[=]
      * text 
        * insert Translation(fr,identifiant)


