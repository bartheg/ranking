module ReportsHelper
  def format_messages(message)
    if message == "Confirmer profile belongs to you. Are you trying to cheat?"
      "Your opponent's profile belongs to YOU!"
    else
      "#{message}"
    end
  end
end
