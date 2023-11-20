({ 

    clickhere: function (component, event, helper) { 


        // Get the values from the form 

        var a = component.find("num1").get("v.value"); 

       

       // Display the Answer in a "toast" status message 

        var resultsToast = $A.get("e.force:showToast"); 

        resultsToast.setParams({ 

            "title": "Answer: " , 

            "message": "Square of the number is: " + (a * a) + "." 

        }); 

        resultsToast.fire(); 

      

        // Close the action panel 

        var dismissActionPanel = $A.get("e.force:closeQuickAction"); 

        dismissActionPanel.fire(); 

    } 


})