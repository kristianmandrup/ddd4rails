I was thinking, why not allow for specifying domain models, contraints etc. externally in a canonical format that can be shared amongst different implementations/frameworks languages?

Fx in JSON format:

domain_model: {
	models: {
		user: {
			// refers to named_types
			name: 'name',
			age: 'age'
		},
		project: {
			name: 'name',
			description: 'description'		
		}
	},
	relations: {
		// refers to models
		// relations can be either: 1-1, 1-M, M-M		
		'user': { 
			'1-1': ['user': {
					belongs_to: 'parent', 
					permissions: {
						roles: {
							create: ['admin'],
							update: ['>guest'],
							destroy: ['admin']							
						}
					}
					comment: 'user belongs to one parent'}
			],						
			'1-M': ['item': {
								owns_many, 
								dependent: 'destroy',
								comment: 'user has many items, ownership used by Hobo to set permission system rights!'								
					}
			],
		  	'M-M' : [
				'project', 
				'user': {
					as: 'friend',
					comment: 'user has many friends'
				},
			]
		}
	},
	named_types: {
		name: {
			type:'string',
			constraints: {
				'required'
			}
		},
		description: {
			type:'text',
			constraints: {
				size: {min: 1, max: 2000},
				'required'
			}
		},
		age: {
			type: 'integer',
			constraints: {
				age: {range: {1, 65}, 'required'}
			}
		}
	},
	permissions: {
		roles: ['guest', 'project_admin', 'admin']
	}
	
	includes : ['blogs', 'registrations']	
}

Then have a rake scriptor similar parse this model and update/refactor the hobo models/controllers accordingly.
The idea here is, that other parsers/populators could be created for: "normal" Rails, Grails, Spring ROO, Java, ... etc.
Also, to avoid the bloated format of something like UML. You could even have an app that can display the model relationships graphically!

Is this a good idea, or is it flawed in some fundamental way. 

Kristian