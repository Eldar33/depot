module CounterIndexStore
  extend ActiveSupport::Concern

  private 

  def increase_counter
    if session[:counter].nil? 
      session[:counter] = 0
    end

    session[:counter] += 1
    @counter = session[:counter]
  end

  def reset_counter
    if session[:counter].nil? 
      session[:counter] = 0
    end
    session[:counter] = 0
  end

end