class User < ActiveRecord::Base

  hobo_model
  
  # fields do
  # ...
  # end

  # fields do ... end
  
  HELLO
  fields do
    # X
    # Y
    # Z
    # WR
    # SD

    A ###
    B ###
    C ###

  end

  # belongs_to :x
  belongs_to :x


  # has_many :x,
  #         :through => y,
  #         :limit => 3

  
  has_many :x,
           :through => 'user',
           
           :limit => 3 #end
           
                     
end
