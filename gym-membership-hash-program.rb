require "date"
#require "pry"

gym_membership = {
  "Ahamed Abbas": {
    "date of birth": "09/11/1994",
    "last visited": "03/10/2018",
    "no of visits": 43,
    "member since": "01/18/2017",
    "membership type": "black",
    "violations": {"violation?": true, "no of violations": 1},
    "locker": {"locker?": true, "locker no": 400},
    "privileges": ["Suana", "Massage chair", "Bathing"],
    "classes": {
      "attended": [
          {"upper-body training": {"scheduled": "10:30AM 03/12/2017", "instructor": "Paul Ryan"}
          }, 
          {"heavy lifts": {"scheduled": "12:30 PM 04/12/2017", "instructor": "Paul Ryan"}
          },  
          {"lower-body training": {"scheduled": "9:30 AM 05/18/2017", "instructor": "Ronaldo Martinez"}
          },  
          {"weight loss training": {"scheduled": "1:30 PM 01/18/2018", "instructor": "Jim Carrey"}
          }
          ],
      "registered": [
        {"30-minute circuit": {"scheduled": "12:00 PM 04/01/2018", "instructor": "James Paulatino"}
        },
        {"weight loss training": {"scheduled": "1:30 PM 04/02/2018", "instructor": "Jim Carrey"}
        },
        {"heavy lifts": {"scheduled": "12:30 PM 04/03/2018", "instructor": "Paul Ryan"}
        },
        {"30-minute circuit": {"scheduled": "12:00 PM 04/18/2018",
          "instructor": "James Paulatino"}
        }
        ],
      "cancelled": [
        {"heavy lifts": {"scheduled": "12:30 PM 03/18/2017", "instructor": "Paul Ryan"}
        }
        ]
    },
    "payment details": {"monthly payment": 10, "last payment date": "03/18/2018", "next payment date": "04/18/2018"}
  }
}

#puts gym_membership[:"Ahamed Abbas"][:"payment details"]


#Person enters the gym
def visit(gym_membership, person_name)
  gym_membership[person_name.to_sym][:"last visited"] = DateTime.now.strftime('%m/%d/%Y')
  gym_membership[person_name.to_sym][:"no of visits"] += 1
  puts "Hello, #{person_name.split(" ")[0]}! Welcome to the gym!"
  
  gym_membership
end

#visit(gym_membership, "Ahamed Abbas")

#Person changes his/her membership
def change_membership(gym_membership, person_name, membership)
  gym_membership[person_name.to_sym][:"membership type"] = membership
  
  if membership == "yellow"
    gym_membership[person_name.to_sym][:"payment details"][:"monthly payment"] = 10
    gym_membership[person_name.to_sym][:"privileges"] = []
  else
    gym_membership[person_name.to_sym][:"privileges"].push("Suana", "Massage chair", "Bathing")
    gym_membership[person_name.to_sym][:"payment details"][:"monthly payment"] = 20
  end
  
  gym_membership
end

#change_membership(gym_membership, "Ahamed Abbas", "yellow")

#Person wants to get a new locker to their account
$available_lockers = [400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500]

def assign_a_locker(gym_membership, person_name)
  if $available_lockers.length == 0
    return "Sorry, no lockers are available"
  end
  
  if gym_membership[person_name.to_sym][:"locker"][:"locker?"]
    return "You already have a locker with us. Your locker number is #{gym_membership[person_name.to_sym][:"locker"][:"locker no"]}"
  end
  
  gym_membership[person_name.to_sym][:"locker"][:"locker?"] = true
  gym_membership[person_name.to_sym][:"locker"][:"locker no"] = $available_lockers.shift()
  
  gym_membership
end

#assign_a_locker(gym_membership, "Ahamed Abbas")

#Person wants to remove a new locker from their account
def remove_a_locker(gym_membership, person_name)
  if !gym_membership[person_name.to_sym][:"locker"][:"locker?"]
    return "Sorry, no locker is available on your account for removal."
  end
  
  locker_no = gym_membership[person_name.to_sym][:"locker"][:"locker no"]
  
  gym_membership[person_name.to_sym][:"locker"][:"locker?"] = false
  $available_lockers.unshift(gym_membership[person_name.to_sym][:"locker"][:"locker no"])
  gym_membership[person_name.to_sym][:"locker"][:"locker no"] = nil
  #puts "Successful removal of locker number #{locker_no} from your account"
  
  gym_membership
end

#remove_a_locker(gym_membership, "Ahamed Abbas")
# puts $available_lockers.inspect

#Person has a violation 
#If more than 3 violations, person is barred from gym
def add_a_violation(gym_membership, person_name)
  gym_membership[person_name.to_sym][:"violations"][:"violation?"] = true
  gym_membership[person_name.to_sym][:"violations"][:"no of violations"] += 1
  total_violations = gym_membership[person_name.to_sym][:"violations"][:"no of violations"]
  
  if total_violations > 2
    gym_membership[person_name.to_sym] = "BARRED!"
    gym_membership
  else
    gym_membership
  end
end

#add_a_violation(gym_membership, "Ahamed Abbas")

#Person wants to attend a class
#Here class_date, class_time and class_name are necessary because they could many similar classes happening on some day

$available_classes = {
  "04/18/2018": [
    {"class": "heavy lifts", "instructor": "Paul Ryan", "time": "12:30 PM", "available?": false}, 
    {"class": "weight loss training", "instructor": "Jim Carrey", "time": "10:30 AM", "available?": false}, 
    {"class": "30-minute circuit", "instructor": "James Paulatino", "time": "12:30 PM", "available?": true},
    {"class": "30-minute circuit", "instructor": "James Paulatino", "time": "1:30 PM", "available?": false}
    ],
  "04/19/2018": [
    {"class": "heavy lifts", "instructor": "Paul Ryan", "time": "1:30 PM", "available?": true}, 
    {"class": "weight loss training", "instructor": "Jim Carrey", "time": "9:30 AM", "available?": true}
    ]
}
def register_for_a_class(gym_membership, person_name, class_date, class_name, class_time)
  $available_classes.each do |date, classes|
    if class_date.to_sym == date
      classes.each do |class_data_hash|
        if class_data_hash[:"available?"] && class_data_hash[:"time"] == class_time && class_data_hash[:"class"] == class_name 
          gym_membership[person_name.to_sym][:"classes"][:"registered"].push(
          {
            "#{class_name}": {"scheduled": "#{class_time} #{class_date}", "instructor": class_data_hash[:"instructor"]}
          })
          puts "Successful registration: #{class_name} at #{class_time} #{class_date} with #{class_data_hash[:"instructor"]}"
          
          return gym_membership
        end
      end
      
      return "Sorry, #{class_name} at #{class_time} on #{class_date} not available."
    end
  end
  
  return "Sorry, no classes are scheduled on #{class_date}"
end

#register_for_a_class(gym_membership, "Ahamed Abbas", "04/18/2018", "30-minute circuit", "12:30 PM")

#Person attends the class

def attend_a_class(gym_membership, person_name, class_name, class_date, class_time)
  
  gym_membership[person_name.to_sym][:"classes"][:"registered"].each_with_index do |class_data_hash, index|
    if class_data_hash.keys[0].to_s == class_name && class_data_hash[class_data_hash.keys[0]][:"scheduled"] == "#{class_time} #{class_date}"
      gym_membership[person_name.to_sym][:"classes"][:"attended"].push(class_data_hash)
      #remove the class from the registered array
      gym_membership[person_name.to_sym][:"classes"][:"registered"].slice!(index, 1)
      return gym_membership
    end
  end
  
  return "Attendance failure: #{class_name} at #{class_time} on #{class_date} was not registered"
end


#attend_a_class(gym_membership, "Ahamed Abbas", "heavy lifts", "04/03/2018", "12:30 PM")

#Person wants to cancel the class

def cancel_a_class(gym_membership, person_name, class_name, class_date, class_time)
  gym_membership[person_name.to_sym][:"classes"][:"registered"].each_with_index do |class_data_hash, index|
    if class_data_hash.keys()[0] == class_name.to_sym && class_data_hash[class_data_hash.keys()[0]][:"scheduled"] == "#{class_time} #{class_date}"
      gym_membership[person_name.to_sym][:"classes"][:"cancelled"].push(class_data_hash)
      gym_membership[person_name.to_sym][:"classes"][:"registered"].slice!(index, 1)
      return gym_membership
    end
  end

  return "Cancellation failure: #{class_name} at #{class_time} on #{class_date} was not registered"
end

#cancel_a_class(gym_membership, "Ahamed Abbas", "weight loss training", "04/02/2018", "1:30 PM")
