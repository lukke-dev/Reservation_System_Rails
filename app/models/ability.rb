# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Book
    can :read, Home
    can [:read, :create], Reservation, user_id: user.id
    can :manage, :all if user.is_admin
    can :manage, Notification
  end
end
