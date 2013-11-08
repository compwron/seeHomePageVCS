require 'selenium-webdriver'

class ScreenshotTaker

  def initialize config

  end

  def foo
# stuff that should be passed in
    starting_date = ""
    events_page_files = []
    root_dir = ''
    page_to_screenshot = ''
    deploy_command = ''
    directory_to_put_screenshots = ""

    `git checkout master`

    screenshots_taken = events_page_files.map { |filename|
      command = "git log --after #{starting_date} --pretty=format:'%h %cd - %s' #{filename}"
      `#{command}`
    }.map { |commit|
      commit.split(" ").first
    }.each { |commit_hash|
      `git checkout #{commit_hash}`

      `#{deploy_command}`

      # selenium screenshot
      width = 1024
      height = 728
      driver = Selenium::WebDriver.for :firefox
      driver.navigate.to page_to_screenshot
      driver.execute_script %Q{
  window.resizeTo(#{width}, #{height});
}

      `sleep 10`
      driver.save_screenshot(directory_to_put_screenshots + 'screenshot_' + commit_hash + '.png')
      driver.quit
    }.size

    git checkout master
    puts "#{screenshots_taken} screenshots taken"
  end

end