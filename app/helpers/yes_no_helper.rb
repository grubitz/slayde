module YesNoHelper
  def yes_no(value)
    value ? t('yes') : t('no')
  end
end