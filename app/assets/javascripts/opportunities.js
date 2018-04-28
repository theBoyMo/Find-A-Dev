document.addEventListener('turbolinks:load', function() {
  let nextProject = document.getElementById('load-next-project');
  if(nextProject) nextProject.addEventListener('click', callback);

  function callback(e){
    e.preventDefault();

    $.getJSON(e.target.href, (response)=>{
      displayProject(response);
    });
  }

  function displayProject(response){
    let opportunityContainer = document.querySelector('.opportunity-wrap');

	  let opportunity =	
      `<div class="opportunity">
	   	  <h2>${response.title}</h2>
         <p>${response.description}</p>
	     </div>`;

    // include required skills
    if(response.opportunity_skills.length > 0){
       opportunity += 
	   		`<h3>You will have the following capabilities</h3>
	   		<dl class="items skills">`;

	   	response.opportunity_skills.forEach((skill)=>{
	   		opportunity += 		
         `<dt class="skill-title">${skill.title}</dt>
	   		<dd class="skill-description">${skill.description}</dd>`
       });
	   	opportunity += `</dl></div>`;
    }

    // add user avatar
    opportunity += '<div class="author-details"><div class="image">';
	  opportunity += '<img src="'+ response.author.main_image.url + '"  class="circle" alt="profile image" >';
	  opportunity	+= '</div></div>';

    // link to users profile


    // start a conversation form


    // link to next project
    let elm = document.createElement('a');
    if(response.id - 1 > 0){
      let text = document.createTextNode('Next');
      elm.appendChild(text);
      elm.setAttribute('id', 'load-next-project');
      elm.setAttribute('href', '/opportunities/' + (response.id - 1));
      elm.addEventListener('click', callback);

      // opportunity += '<a id="load-next-project" href="/opportunities/' + (response.id - 1) + '">Next</a>';
    }

    opportunityContainer.innerHTML = opportunity;
    opportunityContainer.append(elm);
  }

});